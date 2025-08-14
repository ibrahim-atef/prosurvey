import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/injection_container.dart';
import '../../core/theme/app_theme.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/courses/courses_bloc.dart';
import '../widgets/subject_card.dart';
import 'course_content_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  void _loadSubjects() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<CoursesBloc>().add(LoadSubjects(
        institute: authState.user.institute,
        year: authState.user.year,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('الدورات'),
      ),
      body: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          if (state is CoursesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SubjectsLoaded) {
            return _buildSubjectsList(state.subjects);
          } else if (state is CoursesFailure) {
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
                    onPressed: _loadSubjects,
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text('لا توجد دورات متاحة'),
          );
        },
      ),
    );
  }

  Widget _buildSubjectsList(subjects) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SubjectCard(
            subject: subject,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CourseContentScreen(subject: subject),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
