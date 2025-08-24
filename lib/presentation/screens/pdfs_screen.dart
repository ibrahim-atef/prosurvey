import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../core/di/injection_container.dart';
import '../blocs/pdf_content/pdf_content_cubit.dart';
import '../../domain/entities/pdf_content.dart';
import 'pdf_viewer_screen.dart';

class PDFsScreen extends StatefulWidget {
  const PDFsScreen({super.key});

  @override
  State<PDFsScreen> createState() => _PDFsScreenState();
}

class _PDFsScreenState extends State<PDFsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PdfContentCubit>(),
      child: Builder(
        builder: (context) {
          // Load content when the widget is built and provider is available
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              context.read<PdfContentCubit>().loadPdfContent();
            }
          });
          
          return Scaffold(
            backgroundColor: AppTheme.backgroundColor,
            appBar: AppBar(
              title: const Text(
                'الملفات PDF',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            body: BlocBuilder<PdfContentCubit, PdfContentState>(
              builder: (context, state) {
                if (state is PdfContentLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppTheme.primaryColor,
                    ),
                  );
                } else if (state is PdfContentLoaded) {
                  return _buildPdfList(context, state.pdfContent);
                } else if (state is PdfContentFailure) {
                  return _buildErrorState(context, state.message);
                } else {
                  return const Center(
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
                          'لا توجد ملفات PDF متاحة',
                          style: AppTheme.bodyStyle,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPdfList(BuildContext context, PdfContentResponse pdfContent) {
    if (pdfContent.content.isEmpty) {
      return const Center(
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
              'لا توجد ملفات PDF متاحة حالياً',
              style: AppTheme.headingStyle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'سيتم إضافة ملفات PDF جديدة قريباً',
              style: AppTheme.captionStyle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Header with count
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.picture_as_pdf,
                color: AppTheme.primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'الملفات PDF (${pdfContent.content.length})',
                style: AppTheme.subheadingStyle,
              ),
            ],
          ),
        ),
        // PDF list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: pdfContent.content.length,
            itemBuilder: (context, index) {
              final pdf = pdfContent.content[index];
              return _buildPdfCard(context, pdf);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPdfCard(BuildContext context, PdfContentItem pdf) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _openPdf(context, pdf),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pdf.title,
                          style: AppTheme.headingStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pdf.description,
                          style: AppTheme.captionStyle.copyWith(
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildInfoChip(
                    Icons.subject,
                    pdf.subjectName,
                    AppTheme.primaryColor,
                  ),
                  _buildInfoChip(
                    Icons.library_books,
                    'الوحدة ${pdf.unitNumber}',
                    AppTheme.secondaryColor,
                  ),
                  _buildInfoChip(
                    Icons.storage,
                    '${pdf.fileSizeMb} MB',
                    AppTheme.accentColor,
                  ),
                  if (pdf.isFree == 1)
                    _buildInfoChip(
                      Icons.check_circle,
                      'مجاني',
                      Colors.green,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.visibility,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${pdf.viewCount} مشاهدة',
                        style: AppTheme.captionStyle,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.download,
                        size: 16,
                        color: AppTheme.textSecondaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${pdf.downloadCount} تحميل',
                        style: AppTheme.captionStyle,
                      ),
                    ],
                  ),
                  Text(
                    pdf.uploadDate.split(' ')[0], // Show only date
                    style: AppTheme.captionStyle.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _openPdf(BuildContext context, PdfContentItem pdf) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PDFViewerScreen(content: pdf),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
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
          const Text(
            'حدث خطأ',
            style: AppTheme.headingStyle,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTheme.captionStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<PdfContentCubit>().loadPdfContent(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
