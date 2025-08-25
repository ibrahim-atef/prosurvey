import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_system.dart';
import '../../core/di/injection_container.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/exams/exams_bloc.dart';
import '../widgets/subscription_card.dart';
import 'courses_screen.dart';
import 'exams_screen.dart';
import 'login_screen.dart';
import 'videos_screen.dart';
import 'pdfs_screen.dart';
import 'sheets_screen.dart';
import 'contact_us_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: DesignSystem.durationSlow,
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: DesignSystem.durationSlow,
      vsync: this,
    );
    
    _fadeAnimation = DesignSystem.fadeInAnimation(_fadeController);
    _slideAnimation = DesignSystem.slideUpAnimation(_slideController);
    
    // Start animations
    Future.delayed(const Duration(milliseconds: 200), () {
      _fadeController.forward();
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return _buildDashboard(context, state.user);
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.school,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'معهد المساحه',
            style: AppTheme.titleStyle.copyWith(
              color: AppTheme.textPrimaryColor,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: AppTheme.errorColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            icon: Icon(
              Icons.logout,
              color: AppTheme.errorColor,
            ),
            onPressed: () {
              _showLogoutDialog(context);
            },
            tooltip: 'تسجيل الخروج',
          ),
        ),
      ],
      elevation: 0,
      backgroundColor: AppTheme.surfaceColor,
      foregroundColor: AppTheme.textPrimaryColor,
    );
  }

  Widget _buildDashboard(BuildContext context, user) {
    return SingleChildScrollView(
      padding: DesignSystem.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section with enhanced design
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: DesignSystem.radius20,
                  boxShadow: DesignSystem.shadow8,
                ),
                child: Padding(
                  padding: DesignSystem.cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // Profile Avatar
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppTheme.highlightColor,
                                width: 3,
                              ),
                              boxShadow: DesignSystem.shadow4,
                            ),
                            child: user.profileImage != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(17),
                                    child: Image.network(
                                      user.profileImage,
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(
                                          Icons.person,
                                          size: 35,
                                          color: AppTheme.primaryColor,
                                        );
                                      },
                                    ),
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 35,
                                    color: AppTheme.primaryColor,
                                  ),
                          ),
                          const SizedBox(width: 20),
                          
                          // User Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'أهلا بيك يا بشمهندس ${user.name}',
                                  style: AppTheme.headingStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    '${user.institute} - ${user.year}',
                                    style: AppTheme.captionStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Tagline
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: DesignSystem.radius16,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: AppTheme.highlightColor,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'أول منصة تعليمية في مصر لشرح مواد معهد المساحة أونلاين',
                                style: AppTheme.bodyStyle.copyWith(
                                  color: Colors.white,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),

          // Subscription Card
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SubscriptionCard(
                daysLeft: user.subscriptionDaysLeft,
              ),
            ),
          ),
          
          const SizedBox(height: 32),

          // Navigation Menu Section
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 4,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: AppTheme.accentGradient,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'القائمة الرئيسية',
                        style: AppTheme.subheadingStyle.copyWith(
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Menu Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: DesignSystem.getResponsiveGridCount(context),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
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
                          MaterialPageRoute(
                            builder: (_) => BlocProvider(
                              create: (_) => sl<ExamsBloc>(),
                              child: const ExamsScreen(),
                            ),
                          ),
                        ),
                      ),
                      _buildMenuCard(
                        context,
                        'الملفات PDF',
                        Icons.picture_as_pdf,
                        AppTheme.errorColor,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PDFsScreen()),
                        ),
                      ),
                      _buildMenuCard(
                        context,
                        'تواصل معنا',
                        Icons.contact_support,
                        AppTheme.successColor,
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ContactUsScreen()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 40),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: DesignSystem.radius16,
        boxShadow: DesignSystem.shadow4,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: DesignSystem.radius16,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: DesignSystem.radius16,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.9),
                  color,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -15,
                  left: -15,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                
                // Content
                Padding(
                  padding: DesignSystem.cardPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          icon,
                          size: 32,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: AppTheme.titleStyle.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: DesignSystem.radius20,
          ),
          title: Row(
            children: [
              Icon(
                Icons.logout,
                color: AppTheme.errorColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                "تسجيل الخروج",
                style: AppTheme.titleStyle.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
            ],
          ),
          content: Text(
            "هل أنت متأكد من أنك تريد تسجيل الخروج؟",
            style: AppTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "إلغاء",
                style: TextStyle(color: AppTheme.textSecondaryColor),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                context.read<AuthBloc>().add(LogoutRequested());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
              icon: const Icon(Icons.logout, size: 18),
              label: const Text("تأكيد"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
