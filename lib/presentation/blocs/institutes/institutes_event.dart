import 'package:equatable/equatable.dart';

abstract class InstitutesEvent extends Equatable {
  const InstitutesEvent();

  @override
  List<Object?> get props => [];
}

class LoadInstitutes extends InstitutesEvent {
  const LoadInstitutes();
}

class LoadInstituteDetails extends InstitutesEvent {
  final String instituteId;

  const LoadInstituteDetails(this.instituteId);

  @override
  List<Object?> get props => [instituteId];
}

class LoadAcademicPrograms extends InstitutesEvent {
  final String? instituteId;

  const LoadAcademicPrograms({this.instituteId});

  @override
  List<Object?> get props => [instituteId];
}

class LoadProgramByType extends InstitutesEvent {
  final String programType;

  const LoadProgramByType(this.programType);

  @override
  List<Object?> get props => [programType];
}
