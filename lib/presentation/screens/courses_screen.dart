import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/design_system.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/courses/courses_bloc.dart';
import '../widgets/subject_card.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'units_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<dynamic> _filteredSubjects = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadSubjects();
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

  void _loadSubjects() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<CoursesBloc>().add(const CheckAndLoadSubjects());
    }
  }

  void _filterSubjects(List<dynamic> subjects) {
    if (_searchQuery.isEmpty) {
      _filteredSubjects = subjects;
    } else {
      _filteredSubjects = subjects.where((subject) {
        final name = subject.name?.toString().toLowerCase() ?? '';
        final nameArabic = subject.nameArabic?.toString().toLowerCase() ?? '';
        final query = _searchQuery.toLowerCase();
        return name.contains(query) || nameArabic.contains(query);
      }).toList();
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(),
      body: BlocBuilder<CoursesBloc, CoursesState>(
         builder: (context, state) {
           // Debug logging
           print('🔍 CoursesScreen State: ${state.runtimeType}');
           if (state is CoursesDataLoaded) {
             print('📊 CoursesDataLoaded - isLoading: ${state.isLoading}, errorMessage: ${state.errorMessage}, subjectsCount: ${state.subjects?.length}');
           }
           
           if (state is CoursesDataLoaded) {
             if (state.isLoading) {
               return _buildLoadingState();
             } else if (state.errorMessage != null) {
               return _buildErrorState(state.errorMessage!, _loadSubjects);
             } else if (state.subjects != null && state.subjects!.isNotEmpty) {
               _filterSubjects(state.subjects!);
               return _buildSubjectsContent(state.subjects!);
             } else {
               return _buildEmptyState();
             }
           } else if (state is SubjectsLoaded) {
             print('📚 SubjectsLoaded - subjectsCount: ${state.subjects.length}');
             _filterSubjects(state.subjects);
             return _buildSubjectsContent(state.subjects);
           } else if (state is CoursesLoading) {
             return _buildLoadingState();
           } else if (state is CoursesFailure) {
             return _buildErrorState(state.message, _loadSubjects);
           } else if (state is CoursesInitial) {
             return _buildLoadingState();
           }
           return _buildEmptyState();
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
            'الدورات التعليمية',
            style: AppTheme.titleStyle.copyWith(
              color: AppTheme.textPrimaryColor,
            ),
          ),
        ],
      ),
      elevation: 0,
      backgroundColor: AppTheme.surfaceColor,
      foregroundColor: AppTheme.textPrimaryColor,
    );
  }

  Widget _buildSearchBar() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: DesignSystem.marginH16,
          child: SearchTextField(
            controller: _searchController,
            hintText: 'البحث في الدورات...',
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            onClear: () {
              setState(() {
                _searchQuery = '';
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectsContent(List<dynamic> subjects) {
    return Column(
      children: [
        const SizedBox(height: 16),
        
        // Search Bar
        _buildSearchBar(),
        
        const SizedBox(height: 24),
        
        // Header Section
        FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Padding(
              padding: DesignSystem.paddingH16,
              child: Row(
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
                    'المواد المتاحة',
                    style: AppTheme.subheadingStyle.copyWith(
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      '${_filteredSubjects.length} مادة',
                      style: AppTheme.captionStyle.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        // Subjects List
        Expanded(
          child: _filteredSubjects.isEmpty
              ? _buildNoResultsState()
              : _buildSubjectsList(_filteredSubjects),
        ),
      ],
    );
  }

  Widget _buildSubjectsList(List<dynamic> subjects) {
    return GridView.builder(
      padding: DesignSystem.paddingH16,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SubjectCard(
              subject: subject,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UnitsScreen(subject: subject),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'جاري تحميل الدورات...',
            style: AppTheme.bodyStyle.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message, VoidCallback onRetry) {
    return Center(
      child: Padding(
        padding: DesignSystem.paddingH24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.error_outline,
                size: 50,
                color: AppTheme.errorColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'حدث خطأ',
              style: AppTheme.headingStyle.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: AppTheme.bodyStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              text: 'إعادة المحاولة',
              onPressed: onRetry,
              icon: Icons.refresh,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: DesignSystem.paddingH24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppTheme.infoColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.school_outlined,
                size: 50,
                color: AppTheme.infoColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'لا توجد دورات متاحة',
              style: AppTheme.headingStyle.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'سيتم إضافة الدورات قريباً',
              style: AppTheme.bodyStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Padding(
        padding: DesignSystem.paddingH24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.warningColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(
                Icons.search_off,
                size: 40,
                color: AppTheme.warningColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'لا توجد نتائج',
              style: AppTheme.subheadingStyle.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'جرب البحث بكلمات مختلفة',
              style: AppTheme.bodyStyle.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
