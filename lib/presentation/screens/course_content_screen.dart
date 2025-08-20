import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection_container.dart';
import '../../core/theme/app_theme.dart';
import '../blocs/courses/courses_bloc.dart';
import '../../domain/entities/subject.dart';
import '../../domain/entities/course_content.dart';
import '../../domain/entities/unit_content.dart';
import 'video_player_screen.dart';
import 'pdf_viewer_screen.dart';

class CourseContentScreen extends StatefulWidget {
  final Subject subject;

  const CourseContentScreen({
    super.key,
    required this.subject,
  });

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}

class _CourseContentScreenState extends State<CourseContentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadContent();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadContent() {
    context.read<CoursesBloc>().add(LoadCourseContent(
      subjectId: widget.subject.id.toString(),
      type: ContentType.video,
    ));
  }

  // Helper function to convert CourseContent to ContentItem
  ContentItem _convertToContentItem(CourseContent content) {
    return ContentItem(
      id: int.tryParse(content.id) ?? 0,
      title: content.title,
      description: content.description ?? '',
      filePath: content.url,
      fileSizeMb: content.fileSize != null ? '${(content.fileSize! / (1024 * 1024)).toStringAsFixed(2)}' : '0',
      durationMinutes: content.duration != null ? content.duration! ~/ 60 : null,
      thumbnailPath: content.thumbnail,
      isFree: 1,
      displayOrder: 1,
      downloadCount: 0,
      viewCount: 0,
      uploadDate: DateTime.now().toString(),
      contentTypeId: content.type == ContentType.video ? 1 : 2,
      typeName: content.type == ContentType.video ? 'video' : 'pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(widget.subject.nameArabic),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الفيديوهات', icon: Icon(Icons.video_library)),
            Tab(text: 'الملفات PDF', icon: Icon(Icons.picture_as_pdf)),
            Tab(text: 'الملفات', icon: Icon(Icons.description)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildContentList(ContentType.video),
          _buildContentList(ContentType.pdf),
          _buildContentList(ContentType.sheet),
        ],
      ),
    );
  }

  Widget _buildContentList(ContentType type) {
    return BlocBuilder<CoursesBloc, CoursesState>(
      builder: (context, state) {
        if (state is CoursesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CourseContentLoaded) {
          final content = state.content.where((c) => c.type == type).toList();
          if (content.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getContentIcon(type),
                    size: 64,
                    color: AppTheme.textSecondaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا يوجد محتوى متاح',
                    style: AppTheme.bodyStyle,
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: content.length,
            itemBuilder: (context, index) {
              return _buildContentCard(content[index]);
            },
          );
        }
        return const Center(child: Text('لا يوجد محتوى متاح'));
      },
    );
  }

  Widget _buildContentCard(CourseContent content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getContentColor(content.type).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getContentIcon(content.type),
            color: _getContentColor(content.type),
          ),
        ),
        title: Text(
          content.title,
          style: AppTheme.bodyStyle,
        ),
        subtitle: content.description != null
            ? Text(
                content.description!,
                style: AppTheme.captionStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: _buildContentTrailing(content),
        onTap: () => _openContent(content),
      ),
    );
  }

  Widget _buildContentTrailing(CourseContent content) {
    switch (content.type) {
      case ContentType.video:
        return Text(
          _formatDuration(content.duration ?? 0),
          style: AppTheme.captionStyle,
        );
      case ContentType.pdf:
      case ContentType.sheet:
        return Text(
          _formatFileSize(content.fileSize ?? 0),
          style: AppTheme.captionStyle,
        );
    }
  }

  void _openContent(CourseContent content) {
    final contentItem = _convertToContentItem(content);
    
    switch (content.type) {
      case ContentType.video:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(content: contentItem),
          ),
        );
        break;
      case ContentType.pdf:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PDFViewerScreen(content: contentItem),
          ),
        );
        break;
      case ContentType.sheet:
        // Handle sheet download/view
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('سيتم إضافة عارض الملفات قريباً'),
            backgroundColor: AppTheme.primaryColor,
          ),
        );
        break;
    }
  }

  IconData _getContentIcon(ContentType type) {
    switch (type) {
      case ContentType.video:
        return Icons.video_library;
      case ContentType.pdf:
        return Icons.picture_as_pdf;
      case ContentType.sheet:
        return Icons.description;
    }
  }

  Color _getContentColor(ContentType type) {
    switch (type) {
      case ContentType.video:
        return AppTheme.primaryColor;
      case ContentType.pdf:
        return Colors.red;
      case ContentType.sheet:
        return Colors.orange;
    }
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
