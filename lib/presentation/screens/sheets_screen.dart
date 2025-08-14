import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class SheetsScreen extends StatelessWidget {
  const SheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('الملفات'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description,
              size: 64,
              color: Colors.orange,
            ),
            SizedBox(height: 16),
            Text(
              'شاشة الملفات',
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
