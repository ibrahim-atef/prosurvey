import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/institutes/get_institutes_usecase.dart';
import '../../../core/usecases/usecase.dart';
import 'institutes_event.dart';
import 'institutes_state.dart';

class InstitutesBloc extends Bloc<InstitutesEvent, InstitutesState> {
  final GetInstitutesUseCase getInstitutesUseCase;
  final GetInstituteDetailsUseCase getInstituteDetailsUseCase;
  final GetAcademicProgramsUseCase getAcademicProgramsUseCase;

  InstitutesBloc({
    required this.getInstitutesUseCase,
    required this.getInstituteDetailsUseCase,
    required this.getAcademicProgramsUseCase,
  }) : super(InstitutesInitial()) {
    on<LoadInstitutes>(_onLoadInstitutes);
    on<LoadInstituteDetails>(_onLoadInstituteDetails);
    on<LoadAcademicPrograms>(_onLoadAcademicPrograms);
    on<LoadProgramByType>(_onLoadProgramByType);
  }

  Future<void> _onLoadInstitutes(
    LoadInstitutes event,
    Emitter<InstitutesState> emit,
  ) async {
    emit(InstitutesLoading());
    
    final result = await getInstitutesUseCase(NoParams());
    
    result.fold(
      (failure) => emit(InstitutesError(failure.message)),
      (institutes) => emit(InstitutesLoaded(institutes)),
    );
  }

  Future<void> _onLoadInstituteDetails(
    LoadInstituteDetails event,
    Emitter<InstitutesState> emit,
  ) async {
    emit(InstitutesLoading());
    
    final result = await getInstituteDetailsUseCase(event.instituteId);
    
    result.fold(
      (failure) => emit(InstitutesError(failure.message)),
      (institute) => emit(InstituteDetailsLoaded(institute)),
    );
  }

  Future<void> _onLoadAcademicPrograms(
    LoadAcademicPrograms event,
    Emitter<InstitutesState> emit,
  ) async {
    emit(InstitutesLoading());
    
    final params = <String, dynamic>{};
    if (event.instituteId != null) {
      params['instituteId'] = event.instituteId;
    }
    
    final result = await getAcademicProgramsUseCase(params);
    
    result.fold(
      (failure) => emit(InstitutesError(failure.message)),
      (programs) => emit(AcademicProgramsLoaded(programs)),
    );
  }

  Future<void> _onLoadProgramByType(
    LoadProgramByType event,
    Emitter<InstitutesState> emit,
  ) async {
    emit(InstitutesLoading());
    
    // This would need a separate use case for getting program by type
    // For now, we'll use the academic programs use case
    final result = await getAcademicProgramsUseCase({});
    
    result.fold(
      (failure) => emit(InstitutesError(failure.message)),
      (programs) {
        final filteredPrograms = programs
            .where((program) => program.programType == event.programType)
            .toList();
        emit(AcademicProgramsLoaded(filteredPrograms));
      },
    );
  }
}
