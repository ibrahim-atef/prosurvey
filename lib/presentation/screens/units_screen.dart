import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/study_unit.dart';
import '../blocs/units/units_cubit.dart';
import '../blocs/content/content_cubit.dart';
import '../widgets/unit_card.dart';
import 'unit_content_screen.dart';

class UnitsScreen extends StatefulWidget {
  final Subject subject;

  const UnitsScreen({
    super.key,
    required this.subject,
  });

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  @override
  void initState() {
    super.initState();
    _loadUnits();
  }

  @override
  void dispose() {
    // Clear content when leaving units screen
    context.read<ContentCubit>().clearContent();
    super.dispose();
  }

  void _loadUnits() {
    context.read<UnitsCubit>().loadUnits(widget.subject.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.subject.nameArabic,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
             body: BlocBuilder<UnitsCubit, UnitsState>(
         builder: (context, state) {
           if (state is UnitsLoading) {
             return const Center(child: CircularProgressIndicator());
           } else if (state is UnitsLoaded) {
             return _buildUnitsList(state.units);
           } else if (state is UnitsFailure) {
             return Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   const Icon(
                     Icons.error_outline,
                     size: 64,
                     color: AppTheme.errorColor,
                   ),
                   const SizedBox(height: 16),
                   Text(
                     state.message,
                     style: AppTheme.bodyStyle,
                     textAlign: TextAlign.center,
                   ),
                   const SizedBox(height: 16),
                   ElevatedButton(
                     onPressed: _loadUnits,
                     child: const Text('إعادة المحاولة'),
                   ),
                 ],
               ),
             );
           }
           return const Center(
             child: Text('لا توجد وحدات متاحة'),
           );
         },
       ),
    );
  }

  Widget _buildUnitsList(List<StudyUnit> units) {
    if (units.isEmpty) {
      return const Center(
        child: Text('لا توجد وحدات متاحة'),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: units.length,
      itemBuilder: (context, index) {
        final unit = units[index];
        return UnitCard(
          unit: unit,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UnitContentScreen(unit: unit),
              ),
            );
          },
        );
      },
    );
  }
}
