import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/course_content.dart';

class PDFViewerScreen extends StatelessWidget {
  final CourseContent content;

  const PDFViewerScreen({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(content.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.picture_as_pdf,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              content.title,
              style: AppTheme.headingStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (content.description != null)
              Text(
                content.description!,
                style: AppTheme.captionStyle,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 20),
            const Text(
              'سيتم إضافة عارض PDF قريباً',
              style: AppTheme.bodyStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
