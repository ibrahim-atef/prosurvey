import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/study_unit.dart';

class UnitCard extends StatelessWidget {
  final StudyUnit unit;
  final VoidCallback onTap;

  const UnitCard({
    super.key,
    required this.unit,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Unit Number Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child:  Icon(
                    Icons.numbers,
                    color: AppTheme.primaryColor,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              
              // Unit Title
              Text(
                unit.titleArabic,
                style: AppTheme.subheadingStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Unit Description
              if (unit.description != null && unit.description!.isNotEmpty)
                Text(
                  unit.description!,
                  style: AppTheme.captionStyle.copyWith(
                    fontSize: 11,
                    color: AppTheme.textSecondaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              
              const SizedBox(height: 8),
              
              // Unit Type Indicators

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitIndicator(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 12,
          color: AppTheme.textSecondaryColor,
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: AppTheme.captionStyle.copyWith(
            fontSize: 10,
            color: AppTheme.textSecondaryColor,
          ),
        ),
      ],
    );
  }
}
