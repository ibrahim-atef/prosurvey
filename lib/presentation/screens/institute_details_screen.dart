import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/institute.dart';
import '../blocs/institutes/institutes_bloc.dart';
import '../blocs/institutes/institutes_event.dart';
import '../blocs/institutes/institutes_state.dart';

class InstituteDetailsScreen extends StatefulWidget {
  final String instituteId;

  const InstituteDetailsScreen({
    super.key,
    required this.instituteId,
  });

  @override
  State<InstituteDetailsScreen> createState() => _InstituteDetailsScreenState();
}

class _InstituteDetailsScreenState extends State<InstituteDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InstitutesBloc>().add(LoadInstituteDetails(widget.instituteId));
    context.read<InstitutesBloc>().add(LoadAcademicPrograms(instituteId: widget.instituteId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('تفاصيل المعهد'),
        centerTitle: true,
      ),
      body: BlocBuilder<InstitutesBloc, InstitutesState>(
        builder: (context, state) {
          if (state is InstitutesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is InstituteDetailsLoaded) {
            return _buildInstituteDetails(state.institute);
          } else if (state is InstitutesError) {
            return _buildErrorWidget(state.message);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildInstituteDetails(Institute institute) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Institute Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.school,
                    size: 60,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),

                  // Name
                  Text(
                    institute.name,
                    style: AppTheme.headingStyle,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),

                  // Code
                  Text(
                    institute.code,
                    style: AppTheme.subheadingStyle.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Contact Information
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'معلومات المعهد',
                    style: AppTheme.subheadingStyle,
                  ),
                  const SizedBox(height: 16),

                  if (institute.location.isNotEmpty)
                    _buildContactItem(
                      Icons.location_on,
                      'الموقع',
                      institute.location,
                    ),

                  if (institute.contactNumbers != null &&
                      institute.contactNumbers!.isNotEmpty)
                    _buildContactItem(
                      Icons.phone,
                      'الهاتف',
                      institute.contactNumbers!,
                      onTap: () => _launchUrl('tel:${institute.contactNumbers}'),
                    ),

                  _buildContactItem(
                    Icons.calendar_today,
                    'تاريخ الإنشاء',
                    institute.createdAt,
                  ),

                  _buildContactItem(
                    Icons.update,
                    'آخر تحديث',
                    institute.updatedAt,
                  ),

                  _buildContactItem(
                    Icons.list,
                    'عدد البرامج الأكاديمية',
                    institute.programsCount.toString(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Academic Programs
          BlocBuilder<InstitutesBloc, InstitutesState>(
            builder: (context, state) {
              if (state is AcademicProgramsLoaded) {
                return _buildAcademicPrograms(state.programs);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.captionStyle.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 2),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    value,
                    style: AppTheme.bodyStyle.copyWith(
                      color: onTap != null ? AppTheme.primaryColor : null,
                      decoration: onTap != null ? TextDecoration.underline : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcademicPrograms(List programs) {
    if (programs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'البرامج الأكاديمية',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: programs.length,
              itemBuilder: (context, index) {
                final program = programs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          program.nameArabic,
                          style: AppTheme.bodyStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          program.name,
                          style: AppTheme.captionStyle.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        if (program.description != null) ...[
                          const SizedBox(height: 8),
                          Text(
                            program.description!,
                            style: AppTheme.captionStyle,
                          ),
                        ],
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${program.duration} شهر',
                              style: AppTheme.captionStyle.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
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
              context.read<InstitutesBloc>().add(LoadInstituteDetails(widget.instituteId));
            },
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('لا يمكن فتح الرابط: $url'),
        ),
      );
    }
  }
}
