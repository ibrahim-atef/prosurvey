import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/di/injection_container.dart';
import '../../core/theme/app_theme.dart';
import '../blocs/auth/auth_bloc.dart';
import '../widgets/subscription_card.dart';
import 'courses_screen.dart';
import 'exams_screen.dart';
import 'videos_screen.dart';
import 'pdfs_screen.dart';
import 'sheets_screen.dart';
import 'contact_us_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Learn Surveying'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return _buildDashboard(context, state.user);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppTheme.primaryColor,
                        child: user.profileImage != null
                            ? ClipOval(
                                child: Image.network(
                                  user.profileImage,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'أهلا بيك يا بشمهندس ${user.name}',
                              style: AppTheme.headingStyle,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${user.institute} - ${user.year}',
                              style: AppTheme.captionStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'أول منصة تعليمية في مصر لشرح مواد معهد المساحة أونلاين',
                    style: AppTheme.bodyStyle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Subscription Card
          SubscriptionCard(
            daysLeft: user.subscriptionDaysLeft,
          ),
          const SizedBox(height: 20),

          // Navigation Menu
          const Text(
            'القائمة الرئيسية',
            style: AppTheme.subheadingStyle,
          ),
          const SizedBox(height: 16),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              _buildMenuCard(
                context,
                'الدورات',
                Icons.school,
                AppTheme.primaryColor,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CoursesScreen()),
                ),
              ),
              _buildMenuCard(
                context,
                'الامتحانات',
                Icons.quiz,
                AppTheme.secondaryColor,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExamsScreen()),
                ),
              ),
              _buildMenuCard(
                context,
                'الفيديوهات',
                Icons.video_library,
                AppTheme.accentColor,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VideosScreen()),
                ),
              ),
              _buildMenuCard(
                context,
                'الملفات PDF',
                Icons.picture_as_pdf,
                Colors.red,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PDFsScreen()),
                ),
              ),
              _buildMenuCard(
                context,
                'الملفات',
                Icons.description,
                Colors.orange,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SheetsScreen()),
                ),
              ),
              _buildMenuCard(
                context,
                'تواصل معنا',
                Icons.contact_support,
                Colors.green,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.8),
                color,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Cairo',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
