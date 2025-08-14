import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('الفيديوهات'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library,
              size: 64,
              color: AppTheme.primaryColor,
            ),
            SizedBox(height: 16),
            Text(
              'شاشة الفيديوهات',
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
