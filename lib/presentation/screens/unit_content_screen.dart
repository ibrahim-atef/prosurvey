import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/unit.dart' show StudyUnit;
import '../../domain/entities/unit_content.dart';
import '../blocs/content/content_cubit.dart';
import 'video_player_screen.dart';
import 'pdf_viewer_screen.dart';

class UnitContentScreen extends StatefulWidget {
  final StudyUnit unit;

  const UnitContentScreen({
    super.key,
    required this.unit,
  });

  @override
  State<UnitContentScreen> createState() => _UnitContentScreenState();
}

class _UnitContentScreenState extends State<UnitContentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadContent();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadContent() {
    context.read<ContentCubit>().loadUnitContent(widget.unit.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(widget.unit.unitTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'الفيديوهات', icon: Icon(Icons.video_library)),
            Tab(text: 'الملفات PDF', icon: Icon(Icons.picture_as_pdf)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildContentList('video'),
          _buildContentList('pdf'),
        ],
      ),
    );
  }

           Widget _buildContentList(String contentType) {
           return BlocBuilder<ContentCubit, ContentState>(
             builder: (context, state) {
               if (state is ContentLoading) {
                 return const Center(child: CircularProgressIndicator());
               } else if (state is ContentLoaded) {
                 final content = state.unitContent.content
                     .where((c) => c.typeName.toLowerCase() == contentType)
                     .toList();
                 
                 if (content.isEmpty) {
                   return Center(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(
                           contentType == 'video' ? Icons.video_library : Icons.picture_as_pdf,
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
               } else if (state is ContentFailure) {
                 return Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const Icon(
                         Icons.error_outline,
                         size: 64,
                         color: AppTheme.errorColor,
                       ),
                       const SizedBox(height: 16),
                       Text(
                         state.message,
                         style: AppTheme.bodyStyle,
                         textAlign: TextAlign.center,
                       ),
                       const SizedBox(height: 16),
                       ElevatedButton(
                         onPressed: _loadContent,
                         child: const Text('إعادة المحاولة'),
                       ),
                     ],
                   ),
                 );
               }
               return const Center(child: Text('لا يوجد محتوى متاح'));
             },
           );
         }

  Widget _buildContentCard(ContentItem content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getContentColor(content.typeName).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getContentIcon(content.typeName),
            color: _getContentColor(content.typeName),
          ),
        ),
        title: Text(
          content.title,
          style: AppTheme.bodyStyle,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content.description,
              style: AppTheme.captionStyle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                if (content.durationMinutes != null) ...[
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppTheme.textSecondaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${content.durationMinutes} دقيقة',
                    style: AppTheme.captionStyle,
                  ),
                  const SizedBox(width: 16),
                ],
                Icon(
                  Icons.storage,
                  size: 16,
                  color: AppTheme.textSecondaryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  '${content.fileSizeMb} MB',
                  style: AppTheme.captionStyle,
                ),
              ],
            ),
          ],
        ),
        trailing: _buildContentTrailing(content),
        onTap: () => _openContent(content),
      ),
    );
  }

  Widget _buildContentTrailing(ContentItem content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (content.isFree == 1)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'مجاني',
              style: AppTheme.captionStyle.copyWith(
                color: Colors.green,
                fontSize: 10,
              ),
            ),
          ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.visibility,
              size: 16,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(width: 4),
            Text(
              '${content.viewCount}',
              style: AppTheme.captionStyle,
            ),
          ],
        ),
      ],
    );
  }

  void _openContent(ContentItem content) {
    switch (content.typeName.toLowerCase()) {
      case 'video':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VideoPlayerScreen(content: content),
          ),
        );
        break;
      case 'pdf':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PDFViewerScreen(content: content),
          ),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('نوع المحتوى غير مدعوم: ${content.typeName}'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
    }
  }

  IconData _getContentIcon(String typeName) {
    switch (typeName.toLowerCase()) {
      case 'video':
        return Icons.video_library;
      case 'pdf':
        return Icons.picture_as_pdf;
      default:
        return Icons.description;
    }
  }

  Color _getContentColor(String typeName) {
    switch (typeName.toLowerCase()) {
      case 'video':
        return AppTheme.primaryColor;
      case 'pdf':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
