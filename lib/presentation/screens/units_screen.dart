import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/unit.dart' show StudyUnit;
import '../blocs/units/units_cubit.dart';
import '../blocs/content/content_cubit.dart';
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
        title: Text(widget.subject.nameArabic),
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
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: units.length,
      itemBuilder: (context, index) {
        final unit = units[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${unit.unitNumber}',
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
            title: Text(
              unit.unitTitle,
              style: AppTheme.bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unit.description,
                  style: AppTheme.captionStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppTheme.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${unit.estimatedDurationHours} ساعة',
                      style: AppTheme.captionStyle,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.folder,
                      size: 16,
                      color: AppTheme.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${unit.contentCount} محتوى',
                      style: AppTheme.captionStyle,
                    ),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UnitContentScreen(unit: unit),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
