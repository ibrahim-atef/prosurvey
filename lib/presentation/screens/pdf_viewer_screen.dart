import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/url_utils.dart';
import '../../domain/entities/base_content.dart';

class PDFViewerScreen extends StatefulWidget {
  final BaseContent content;

  const PDFViewerScreen({
    super.key,
    required this.content,
  });

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    try {
      final String fullUrl = UrlUtils.buildFullUrl(widget.content.filePath);
      final Uri? uri = UrlUtils.parseUrl(fullUrl);
      
      if (uri == null) {
        throw Exception('Invalid URL format: $fullUrl');
      }
      
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              if (progress == 100) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (WebResourceError error) {
              setState(() {
                _isLoading = false;
                _hasError = true;
                _errorMessage = 'خطأ في تحميل الملف: ${error.description}';
              });
            },
          ),
        )
        ..loadRequest(uri);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'خطأ في تحميل الملف: $e';
      });
    }
  }

  Future<void> _openInExternalApp() async {
    try {
      final String fullUrl = UrlUtils.buildFullUrl(widget.content.filePath);
      final Uri? url = UrlUtils.parseUrl(fullUrl);
      
      if (url == null) {
        _showErrorSnackBar('رابط الملف غير صحيح');
        return;
      }
      
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('لا يمكن فتح الملف في التطبيق الخارجي');
      }
    } catch (e) {
      _showErrorSnackBar('خطأ في فتح الملف: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.content.title,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: _openInExternalApp,
            tooltip: 'فتح في تطبيق خارجي',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
              _initializeWebView();
            },
            tooltip: 'إعادة تحميل',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_hasError) {
      return _buildErrorWidget();
    }

    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          Container(
            color: Colors.white,
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'جاري تحميل الملف...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildErrorWidget() {
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
            'خطأ في تحميل الملف',
            style: AppTheme.headingStyle.copyWith(
              color: AppTheme.errorColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (_errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _errorMessage,
                style: AppTheme.bodyStyle.copyWith(
                  color: AppTheme.errorColor,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          const SizedBox(height: 8),

          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _openInExternalApp,
            icon: const Icon(Icons.open_in_new),
            label: const Text('فتح في تطبيق خارجي'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _isLoading = true;
                _hasError = false;
              });
              _initializeWebView();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }
}
