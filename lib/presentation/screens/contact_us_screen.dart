import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('تواصل معنا'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(
                      Icons.contact_support,
                      size: 64,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'تواصل معنا',
                      style: AppTheme.headingStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'نحن هنا لمساعدتك في أي استفسار أو مشكلة',
                      style: AppTheme.bodyStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Phone Numbers
            const Text(
              'أرقام التواصل',
              style: AppTheme.subheadingStyle,
            ),
            const SizedBox(height: 16),

            _buildPhoneCard(
              context,
              '01229159167',
              'الرقم الأول',
              Icons.phone,
            ),
            const SizedBox(height: 12),

            _buildPhoneCard(
              context,
              '01019346005',
              'الرقم الثاني',
              Icons.phone,
            ),
            const SizedBox(height: 12),

            _buildPhoneCard(
              context,
              '01116163849',
              'الرقم الثالث',
              Icons.phone,
            ),
            const SizedBox(height: 12),

            _buildPhoneCard(
              context,
              '01203707408',
              'الرقم الرابع',
              Icons.phone,
            ),
            const SizedBox(height: 20),

            // Additional Info
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'معلومات إضافية',
                      style: AppTheme.subheadingStyle,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '• يمكنك التواصل معنا في أي وقت من الساعة 9 صباحاً حتى 9 مساءً',
                      style: AppTheme.bodyStyle,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• نرد على جميع الاستفسارات خلال 24 ساعة',
                      style: AppTheme.bodyStyle,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• يمكنك أيضاً التواصل معنا عبر الواتساب',
                      style: AppTheme.bodyStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneCard(
    BuildContext context,
    String phoneNumber,
    String title,
    IconData icon,
  ) {
    return Card(
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
          ),
        ),
        title: Text(
          title,
          style: AppTheme.bodyStyle,
        ),
        subtitle: Text(
          phoneNumber,
          style: AppTheme.captionStyle,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () => _makePhoneCall(phoneNumber),
              color: AppTheme.primaryColor,
            ),
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: () => _sendWhatsAppMessage(phoneNumber),
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _sendWhatsAppMessage(String phoneNumber) async {
    final Uri whatsappUri = Uri.parse(
      'https://wa.me/$phoneNumber?text=مرحباً، أريد الاستفسار عن خدمات Learn Surveying',
    );
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    }
  }
}
