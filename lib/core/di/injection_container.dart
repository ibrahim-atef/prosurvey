import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/datasources/local/local_storage.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/course_repository_impl.dart';
import '../../data/repositories/exam_repository_impl.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../data/repositories/institute_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/course_repository.dart';
import '../../domain/repositories/exam_repository.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../domain/repositories/institute_repository.dart';
import '../../domain/usecases/auth/login_usecase.dart';
import '../../domain/usecases/auth/register_usecase.dart';
import '../../domain/usecases/auth/logout_usecase.dart';
import '../../domain/usecases/courses/get_subjects_usecase.dart';
import '../../domain/usecases/courses/get_course_content_usecase.dart';
import '../../domain/usecases/courses/get_units_usecase.dart';
import '../../domain/usecases/courses/get_unit_content_usecase.dart';
import '../../domain/usecases/exams/get_exams_usecase.dart';
import '../../domain/usecases/exams/submit_exam_usecase.dart';
import '../../domain/usecases/institutes/get_institutes_usecase.dart';
import '../../domain/usecases/content/get_content_usecase.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/courses/courses_bloc.dart';
import '../../presentation/blocs/units/units_cubit.dart';
import '../../presentation/blocs/content/content_cubit.dart';
import '../../presentation/blocs/exams/exams_bloc.dart';
import '../../presentation/blocs/institutes/institutes_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  // Dio
  sl.registerLazySingleton(() => Dio());
  
  // Data sources
  sl.registerLazySingleton<ApiClient>(() => ApiClient(sl(),sl()));
  sl.registerLazySingleton<LocalStorage>(() => LocalStorage(sl()));
  
  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<CourseRepository>(() => CourseRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<ExamRepository>(() => ExamRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton<InstituteRepository>(() => InstituteRepositoryImpl(sl()));
  
  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetSubjectsUseCase(sl()));
  sl.registerLazySingleton(() => GetCourseContentUseCase(sl()));
  sl.registerLazySingleton(() => GetUnitsUseCase(sl()));
  sl.registerLazySingleton(() => GetUnitContentUseCase(sl()));
  sl.registerLazySingleton(() => GetExamsUseCase(sl()));
  sl.registerLazySingleton(() => SubmitExamUseCase(sl()));
  sl.registerLazySingleton(() => GetInstitutesUseCase(sl()));
  sl.registerLazySingleton(() => GetInstituteDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetAcademicProgramsUseCase(sl()));
  sl.registerLazySingleton(() => GetStudyUnitsUseCase(sl()));
  sl.registerLazySingleton(() => GetUnitDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetEducationalContentUseCase(sl()));
  sl.registerLazySingleton(() => GetContentByTypeUseCase(sl()));
  sl.registerLazySingleton(() => UpdateContentViewCountUseCase(sl()));
  
  // BLoCs
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));
  sl.registerFactory(() => CoursesBloc(sl(), sl()));
  sl.registerFactory(() => UnitsCubit(sl()));
  sl.registerFactory(() => ContentCubit(sl()));
  sl.registerFactory(() => ExamsBloc(sl(), sl()));
  sl.registerFactory(() => InstitutesBloc(
    getInstitutesUseCase: sl(),
    getInstituteDetailsUseCase: sl(),
    getAcademicProgramsUseCase: sl(),
  ));
}
