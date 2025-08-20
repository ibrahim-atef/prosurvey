import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../blocs/institutes/institutes_bloc.dart';
import '../blocs/institutes/institutes_event.dart';
import '../blocs/institutes/institutes_state.dart';
import '../widgets/institute_card.dart';
import 'institute_details_screen.dart';

class InstitutesScreen extends StatefulWidget {
  const InstitutesScreen({super.key});

  @override
  State<InstitutesScreen> createState() => _InstitutesScreenState();
}

class _InstitutesScreenState extends State<InstitutesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InstitutesBloc>().add(const LoadInstitutes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('المعاهد'),
        centerTitle: true,
      ),
      body: BlocBuilder<InstitutesBloc, InstitutesState>(
        builder: (context, state) {
          if (state is InstitutesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InstitutesLoaded) {
            return _buildInstitutesList(state.institutes);
          } else if (state is InstitutesError) {
            return _buildErrorWidget(state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInstitutesList(List institutes) {
    if (institutes.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد معاهد متاحة حالياً',
          style: AppTheme.bodyStyle,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<InstitutesBloc>().add(const LoadInstitutes());
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: institutes.length,
        itemBuilder: (context, index) {
          final institute = institutes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: InstituteCard(
              institute: institute,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InstituteDetailsScreen(
                      instituteId: institute.id,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'حدث خطأ',
            style: AppTheme.headingStyle,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTheme.bodyStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<InstitutesBloc>().add(const LoadInstitutes());
            },
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
