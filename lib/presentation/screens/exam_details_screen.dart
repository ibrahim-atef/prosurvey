import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../blocs/exams/exams_bloc.dart';
import '../widgets/exam_question_card.dart';

class ExamDetailsScreen extends StatefulWidget {
  final int examId;
  final String examTitle;

  const ExamDetailsScreen({
    super.key,
    required this.examId,
    required this.examTitle,
  });

  @override
  State<ExamDetailsScreen> createState() => _ExamDetailsScreenState();
}

class _ExamDetailsScreenState extends State<ExamDetailsScreen> {
  final Map<int, int> _answers = {};
  bool _isExamStarted = false;
  bool _isExamSubmitted = false;
  DateTime? _examStartTime;
  int _remainingTime = 0;

  @override
  void initState() {
    super.initState();
    _loadExamDetails();
  }

  void _loadExamDetails() {
    context.read<ExamsBloc>().add(LoadExamDetails(widget.examId));
  }

  void _startExam() {
    setState(() {
      _isExamStarted = true;
      _examStartTime = DateTime.now();
      _remainingTime = 60; // Default time, will be updated from API
    });
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _isExamStarted && !_isExamSubmitted && _remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
        _startTimer();
      } else if (_remainingTime <= 0 && !_isExamSubmitted) {
        _submitExam();
      }
    });
  }

  void _submitExam() {
    if (_isExamSubmitted) return;
    
    setState(() {
      _isExamSubmitted = true;
    });

    final List<int> answers = [];
    for (int i = 0; i < 50; i++) { // Assuming max 50 questions
      answers.add(_answers[i] ?? -1);
    }

    context.read<ExamsBloc>().add(SubmitExam(
      examId: widget.examId.toString(),
      answers: answers,
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم إرسال الامتحان بنجاح'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _selectAnswer(int questionId, int optionIndex) {
    if (!_isExamStarted || _isExamSubmitted) return;
    
    setState(() {
      _answers[questionId] = optionIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.examTitle,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          if (_isExamStarted && !_isExamSubmitted)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.timer, color: Colors.red, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: BlocBuilder<ExamsBloc, ExamsState>(
        builder: (context, state) {
          if (state is ExamsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ),
            );
          } else if (state is ExamDetailsLoaded) {
            return _buildExamDetails(context, state);
          } else if (state is ExamsFailure) {
            return _buildErrorState(context, state.message);
          } else {
            return const Center(
              child: Text(
                'جاري تحميل تفاصيل الامتحان...',
                style: AppTheme.bodyStyle,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildExamDetails(BuildContext context, ExamDetailsLoaded state) {
    final examInfo = state.examDetails.examInfo;
    final questions = state.examDetails.questions;

    if (!_isExamStarted) {
      return _buildExamInstructions(context, examInfo);
    }

    return Column(
      children: [
        // Progress bar
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'التقدم: ${_answers.length}/${questions.length}',
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'الوقت المتبقي: ${(_remainingTime ~/ 60).toString().padLeft(2, '0')}:${(_remainingTime % 60).toString().padLeft(2, '0')}',
                    style: AppTheme.bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _remainingTime < 300 ? Colors.red : Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _answers.length / questions.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _answers.length == questions.length ? Colors.green : AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ),
        
        // Questions
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return ExamQuestionCard(
                question: question,
                selectedAnswer: _answers[question.id],
                onAnswerSelected: (optionIndex) => _selectAnswer(question.id, optionIndex),
                questionNumber: index + 1,
              );
            },
          ),
        ),
        
        // Submit button
        if (!_isExamSubmitted)
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _answers.length == questions.length ? _submitExam : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  _answers.length == questions.length 
                    ? 'إرسال الامتحان' 
                    : 'أجب على جميع الأسئلة أولاً (${_answers.length}/${questions.length})',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildExamInstructions(BuildContext context, examInfo) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Exam info card
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.quiz,
                          color: AppTheme.primaryColor,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              examInfo.title,
                              style: AppTheme.headingStyle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              examInfo.description,
                              style: AppTheme.bodyStyle.copyWith(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Exam details
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildInfoItem(
                        Icons.subject,
                        'المادة',
                        examInfo.subjectName,
                        AppTheme.primaryColor,
                      ),
                      _buildInfoItem(
                        Icons.question_answer,
                        'عدد الأسئلة',
                        '${examInfo.totalQuestions}',
                        AppTheme.secondaryColor,
                      ),
                      _buildInfoItem(
                        Icons.timer,
                        'الوقت',
                        '${examInfo.timeLimitMinutes} دقيقة',
                        AppTheme.accentColor,
                      ),
                      _buildInfoItem(
                        Icons.score,
                        'درجة النجاح',
                        '${examInfo.passingPercentage}%',
                        Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Instructions
          Text(
            'تعليمات الامتحان',
            style: AppTheme.subheadingStyle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildInstructionItem(
                    Icons.read_more,
                    'اقرأ جميع الأسئلة بعناية قبل الإجابة',
                    Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildInstructionItem(
                    Icons.schedule,
                    'أدر وقتك بحكمة',
                    Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  _buildInstructionItem(
                    Icons.check_circle,
                    'أجب على جميع الأسئلة',
                    Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildInstructionItem(
                    Icons.rate_review,
                    'راجع إجاباتك قبل الإرسال',
                    Colors.purple,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Start exam button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _remainingTime = examInfo.timeLimitMinutes * 60;
                });
                _startExam();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
              ),
              child: const Text(
                'ابدأ الامتحان',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value, Color color) {
    return Container(
      constraints: const BoxConstraints(minWidth: 120),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTheme.captionStyle.copyWith(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  value,
                  style: AppTheme.bodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: AppTheme.bodyStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
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
            onPressed: _loadExamDetails,
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
