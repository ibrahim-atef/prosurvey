import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('الامتحانات'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.quiz,
              size: 64,
              color: AppTheme.primaryColor,
            ),
            SizedBox(height: 16),
            Text(
              'شاشة الامتحانات',
              style: AppTheme.headingStyle,
            ),
            SizedBox(height: 8),
            Text(
              'سيتم إضافة المحتوى قريباً',
              style: AppTheme.captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
