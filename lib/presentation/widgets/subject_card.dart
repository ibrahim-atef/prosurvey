import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/subject.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;
  final VoidCallback onTap;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Subject Icon
              Container(

                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getSubjectIcon(subject.name),
                  color: AppTheme.primaryColor,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              
              // Subject Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.nameArabic,
                      style: AppTheme.subheadingStyle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    
                    // Content Counts
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        _buildContentCount(Icons.video_library, subject.videoCount, 'فيديو'),
                        _buildContentCount(Icons.picture_as_pdf, subject.pdfCount, 'PDF'),
                        _buildContentCount(Icons.quiz, subject.examCount, 'امتحان'),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Arrow Icon
              const Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.textSecondaryColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentCount(IconData icon, int count, String label) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: AppTheme.textSecondaryColor,
        ),
        const SizedBox(width: 4),
        Text(
          '$count $label',
          style: AppTheme.captionStyle,
        ),
      ],
    );
  }

  IconData _getSubjectIcon(String subjectName) {
    switch (subjectName.toLowerCase()) {
      case 'geodesy':
        return Icons.explore;
      case 'error theory':
        return Icons.analytics;
      case 'quantities':
        return Icons.calculate;
      case 'technical drawing':
        return Icons.draw;
      case 'soil':
        return Icons.eco;
      case 'technology':
        return Icons.computer;
      case 'laws':
        return Icons.gavel;
      default:
        return Icons.school;
    }
  }
}
