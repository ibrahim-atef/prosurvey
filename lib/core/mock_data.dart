// Mock data for testing the Learn Surveying app
// This file contains sample data that can be used for development and testing

class MockData {
  // Sample subjects for سنة أولى (المطرية)
  static const List<Map<String, dynamic>> subjectsFirstYearMataria = [
    {
      'id': 1,
      'name': 'Geodesy',
      'name_arabic': 'ت.المساحة الجيوديسية',
      'icon': 'explore',
      'video_count': 15,
      'pdf_count': 8,
      'exam_count': 3,
      'institute': 'المطرية',
      'year': 'سنة أولى',
    },
    {
      'id': 2,
      'name': 'Error Theory',
      'name_arabic': 'نظرية الأخطاء',
      'icon': 'analytics',
      'video_count': 12,
      'pdf_count': 6,
      'exam_count': 2,
      'institute': 'المطرية',
      'year': 'سنة أولى',
    },
    {
      'id': 3,
      'name': 'Quantities',
      'name_arabic': 'كميات ومواصفات',
      'icon': 'calculate',
      'video_count': 10,
      'pdf_count': 5,
      'exam_count': 2,
      'institute': 'المطرية',
      'year': 'سنة أولى',
    },
    {
      'id': 4,
      'name': 'Technical Drawing',
      'name_arabic': 'رسم تخصصي',
      'icon': 'draw',
      'video_count': 18,
      'pdf_count': 12,
      'exam_count': 4,
      'institute': 'المطرية',
      'year': 'سنة أولى',
    },
    {
      'id': 5,
      'name': 'Soil',
      'name_arabic': 'تربة ومحاصيل',
      'icon': 'eco',
      'video_count': 14,
      'pdf_count': 7,
      'exam_count': 3,
      'institute': 'المطرية',
      'year': 'سنة أولى',
    },
    {
      'id': 6,
      'name': 'Technology',
      'name_arabic': 'تكنولوجيا',
      'icon': 'computer',
      'video_count': 20,
      'pdf_count': 10,
      'exam_count': 5,
      'institute': 'المطرية',
      'year': 'سنة أولى',
    },
    {
      'id': 7,
      'name': 'Laws',
      'name_arabic': 'قوانين وتشريعات',
      'icon': 'gavel',
      'video_count': 8,
      'pdf_count': 15,
      'exam_count': 2,
      'institute': 'المطرية',
      'year': 'سنة أولى',
    },
  ];

  // Sample units for testing
  static const List<Map<String, dynamic>> sampleUnits = [
    {
      'id': 1,
      'unit_title': 'الأعداد والعمليات الحسابية',
      'unit_number': 1,
      'description': 'الأعداد الأساسية والعمليات الحسابية في المساحة',
      'learning_objectives': null,
      'estimated_duration_hours': 2,
      'display_order': 1,
      'subject_id': 1,
      'subject_name': 'الرياضيات التطبيقية',
      'subject_code': 'GIS_ا?_25',
      'content_count': 1
    },
    {
      'id': 2,
      'unit_title': 'الكسور والعمليات عليها',
      'unit_number': 2,
      'description': 'الكسور والعمليات الحسابية عليها',
      'learning_objectives': null,
      'estimated_duration_hours': 2,
      'display_order': 2,
      'subject_id': 1,
      'subject_name': 'الرياضيات التطبيقية',
      'subject_code': 'GIS_ا?_25',
      'content_count': 0
    },
    {
      'id': 3,
      'unit_title': 'النسب المئوية',
      'unit_number': 3,
      'description': 'النسب المئوية وتطبيقاتها في المساحة',
      'learning_objectives': null,
      'estimated_duration_hours': 2,
      'display_order': 3,
      'subject_id': 1,
      'subject_name': 'الرياضيات التطبيقية',
      'subject_code': 'GIS_ا?_25',
      'content_count': 0
    }
  ];

  // Sample unit content for testing
  static const Map<String, dynamic> sampleUnitContent = {
    'unit': {
      'id': 1,
      'unit_title': 'الأعداد والعمليات الحسابية',
      'unit_number': 1,
      'description': 'الأعداد الأساسية والعمليات الحسابية في المساحة',
      'learning_objectives': null,
      'estimated_duration_hours': 2,
      'subject_id': 1,
      'subject_name': 'الرياضيات التطبيقية',
      'subject_code': 'GIS_ا?_25'
    },
    'content': [
      {
        'id': 1,
        'title': 'دليل المساحة الجيوديسية',
        'description': 'دليل شامل للمساحة الجيوديسية',
        'file_path': 'D:\\12 final 2024.pdf',
        'file_size_mb': '0.47',
        'duration_minutes': null,
        'thumbnail_path': null,
        'is_free': 1,
        'display_order': 1,
        'download_count': 0,
        'view_count': 0,
        'upload_date': '2025-08-19 14:06:25',
        'content_type_id': 2,
        'type_name': 'pdf'
      }
    ],
    'content_type_breakdown': [
      {
        'id': 2,
        'type_name': 'pdf',
        'count': 1
      }
    ],
    'pagination': {
      'total': 1,
      'limit': 20,
      'offset': 0,
      'has_more': false
    }
  };

  // Sample course content
  static const List<Map<String, dynamic>> courseContent = [
    {
      'id': '1',
      'title': 'مقدمة في المساحة الجيوديسية',
      'subject_id': '1',
      'type': 'video',
      'url': 'https://example.com/video1.mp4',
      'thumbnail': 'https://example.com/thumb1.jpg',
      'description': 'شرح مفصل لمبادئ المساحة الجيوديسية',
      'duration': 1800, // 30 minutes
      'file_size': null,
    },
    {
      'id': '2',
      'title': 'كتاب المساحة الجيوديسية',
      'subject_id': '1',
      'type': 'pdf',
      'url': 'https://example.com/book1.pdf',
      'thumbnail': null,
      'description': 'كتاب شامل في المساحة الجيوديسية',
      'duration': null,
      'file_size': 2048576, // 2MB
    },
    {
      'id': '3',
      'title': 'ملخص المساحة الجيوديسية',
      'subject_id': '1',
      'type': 'sheet',
      'url': 'https://example.com/sheet1.pdf',
      'thumbnail': null,
      'description': 'ملخص سريع للمفاهيم الأساسية',
      'duration': null,
      'file_size': 512000, // 500KB
    },
    {
      'id': '4',
      'title': 'أساسيات نظرية الأخطاء',
      'subject_id': '2',
      'type': 'video',
      'url': 'https://example.com/video2.mp4',
      'thumbnail': 'https://example.com/thumb2.jpg',
      'description': 'شرح أساسيات نظرية الأخطاء في المساحة',
      'duration': 2400, // 40 minutes
      'file_size': null,
    },
    {
      'id': '5',
      'title': 'كتاب نظرية الأخطاء',
      'subject_id': '2',
      'type': 'pdf',
      'url': 'https://example.com/book2.pdf',
      'thumbnail': null,
      'description': 'كتاب شامل في نظرية الأخطاء',
      'duration': null,
      'file_size': 1536000, // 1.5MB
    },
    {
      'id': '6',
      'title': 'فيديو كميات ومواصفات',
      'subject_id': '3',
      'type': 'video',
      'url': 'https://example.com/video3.mp4',
      'thumbnail': 'https://example.com/thumb3.jpg',
      'description': 'شرح مفصل لكميات ومواصفات المساحة',
      'duration': 3600, // 60 minutes
      'file_size': null,
    },
    {
      'id': '7',
      'title': 'كتاب الرسم التخصصي',
      'subject_id': '4',
      'type': 'pdf',
      'url': 'https://example.com/book4.pdf',
      'thumbnail': null,
      'description': 'كتاب شامل في الرسم التخصصي',
      'duration': null,
      'file_size': 3072000, // 3MB
    },
    {
      'id': '8',
      'title': 'ملخص التربة والمحاصيل',
      'subject_id': '5',
      'type': 'sheet',
      'url': 'https://example.com/sheet5.pdf',
      'thumbnail': null,
      'description': 'ملخص سريع لموضوع التربة والمحاصيل',
      'duration': null,
      'file_size': 256000, // 250KB
    },
  ];

  // Sample exams
  static const List<Map<String, dynamic>> sampleExams = [
    {
      'id': '1',
      'title': 'امتحان المساحة الجيوديسية - الوحدة الأولى',
      'subject_id': '1',
      'time_limit': 60, // 60 minutes
      'total_score': 100,
      'questions': [
        {
          'id': '1',
          'text': 'ما هو تعريف المساحة الجيوديسية؟',
          'options': [
            'علم قياس المسافات',
            'علم قياس الأرض',
            'علم قياس المساحات',
            'علم قياس الأبعاد',
          ],
          'correct_answer_index': 1,
          'score': 10,
        },
        {
          'id': '2',
          'text': 'ما هي الوحدة الأساسية للقياس في المساحة؟',
          'options': [
            'المتر',
            'القدم',
            'الياردة',
            'البوصة',
          ],
          'correct_answer_index': 0,
          'score': 10,
        },
        {
          'id': '3',
          'text': 'ما هو الجهاز المستخدم في قياس الزوايا؟',
          'options': [
            'الميزان',
            'التيودوليت',
            'الشريط',
            'المقياس',
          ],
          'correct_answer_index': 1,
          'score': 10,
        },
      ],
    },
    {
      'id': '2',
      'title': 'امتحان نظرية الأخطاء - الوحدة الأولى',
      'subject_id': '2',
      'time_limit': 45, // 45 minutes
      'total_score': 80,
      'questions': [
        {
          'id': '1',
          'text': 'ما هو الخطأ العشوائي؟',
          'options': [
            'خطأ ثابت',
            'خطأ متغير',
            'خطأ منهجي',
            'خطأ شخصي',
          ],
          'correct_answer_index': 1,
          'score': 20,
        },
        {
          'id': '2',
          'text': 'كيف نحسب المتوسط الحسابي؟',
          'options': [
            'مجموع القيم مقسوم على عددها',
            'أكبر قيمة ناقص أصغر قيمة',
            'القيمة الوسطى',
            'القيمة الأكثر تكراراً',
          ],
          'correct_answer_index': 0,
          'score': 20,
        },
      ],
    },
    {
      'id': '3',
      'title': 'امتحان كميات ومواصفات - الوحدة الأولى',
      'subject_id': '3',
      'time_limit': 90, // 90 minutes
      'total_score': 120,
      'questions': [
        {
          'id': '1',
          'text': 'ما هي وحدة قياس المساحة؟',
          'options': [
            'المتر المربع',
            'المتر المكعب',
            'المتر الخطي',
            'اللتر',
          ],
          'correct_answer_index': 0,
          'score': 15,
        },
        {
          'id': '2',
          'text': 'ما هو حجم المكعب الذي طول ضلعه 3 متر؟',
          'options': [
            '9 متر مكعب',
            '27 متر مكعب',
            '6 متر مكعب',
            '12 متر مكعب',
          ],
          'correct_answer_index': 1,
          'score': 15,
        },
      ],
    },
  ];

  // Sample exam (for backward compatibility)
  static const Map<String, dynamic> sampleExam = {
    'id': '1',
    'title': 'امتحان المساحة الجيوديسية - الوحدة الأولى',
    'subject_id': '1',
    'time_limit': 60, // 60 minutes
    'total_score': 100,
    'questions': [
      {
        'id': '1',
        'text': 'ما هو تعريف المساحة الجيوديسية؟',
        'options': [
          'علم قياس المسافات',
          'علم قياس الأرض',
          'علم قياس المساحات',
          'علم قياس الأبعاد',
        ],
        'correct_answer_index': 1,
        'score': 10,
      },
      {
        'id': '2',
        'text': 'ما هي الوحدة الأساسية للقياس في المساحة؟',
        'options': [
          'المتر',
          'القدم',
          'الياردة',
          'البوصة',
        ],
        'correct_answer_index': 0,
        'score': 10,
      },
      {
        'id': '3',
        'text': 'ما هو الجهاز المستخدم في قياس الزوايا؟',
        'options': [
          'الميزان',
          'التيودوليت',
          'الشريط',
          'المقياس',
        ],
        'correct_answer_index': 1,
        'score': 10,
      },
    ],
  };

  // Sample user data
  static const Map<String, dynamic> sampleUser = {
    'id': '1',
    'name': 'أحمد محمد علي',
    'email': 'ahmed@gmail.com',
    'institute': 'المطرية',
    'year': 'سنة أولى',
    'department': 'مساحة',
    'profile_image': null,
    'subscription_days_left': 30,
    'whatsapp_number': '01234567890',
  };

  // Sample login response
  static const Map<String, dynamic> loginResponse = {
    'user': sampleUser,
    'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
  };

  // Sample register response
  static const Map<String, dynamic> registerResponse = {
    'user': sampleUser,
    'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
  };

  // Sample exam result
  static const Map<String, dynamic> examResult = {
    'exam_id': '1',
    'score': 85,
    'total_score': 100,
    'question_results': [
      {
        'question_id': '1',
        'selected_answer_index': 1,
        'correct_answer_index': 1,
        'is_correct': true,
        'score': 10,
      },
      {
        'question_id': '2',
        'selected_answer_index': 0,
        'correct_answer_index': 0,
        'is_correct': true,
        'score': 10,
      },
      {
        'question_id': '3',
        'selected_answer_index': 2,
        'correct_answer_index': 1,
        'is_correct': false,
        'score': 0,
      },
    ],
    'submitted_at': '2024-01-15T10:30:00Z',
  };
}
