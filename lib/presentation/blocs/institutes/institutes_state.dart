import 'package:equatable/equatable.dart';
import '../../../domain/entities/institute.dart';

abstract class InstitutesState extends Equatable {
  const InstitutesState();

  @override
  List<Object?> get props => [];
}

class InstitutesInitial extends InstitutesState {}

class InstitutesLoading extends InstitutesState {}

class InstitutesLoaded extends InstitutesState {
  final List<Institute> institutes;

  const InstitutesLoaded(this.institutes);

  @override
  List<Object?> get props => [institutes];
}

class InstituteDetailsLoaded extends InstitutesState {
  final Institute institute;

  const InstituteDetailsLoaded(this.institute);

  @override
  List<Object?> get props => [institute];
}

class AcademicProgramsLoaded extends InstitutesState {
  final List<AcademicProgram> programs;

  const AcademicProgramsLoaded(this.programs);

  @override
  List<Object?> get props => [programs];
}

class InstitutesError extends InstitutesState {
  final String message;

  const InstitutesError(this.message);

  @override
  List<Object?> get props => [message];
}
