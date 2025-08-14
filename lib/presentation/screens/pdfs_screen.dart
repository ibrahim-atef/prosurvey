import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class PDFsScreen extends StatelessWidget {
  const PDFsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('الملفات PDF'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf,
              size: 64,
              color: Colors.red,
            ),
            SizedBox(height: 16),
            Text(
              'شاشة الملفات PDF',
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
