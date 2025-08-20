part of 'units_cubit.dart';

abstract class UnitsState extends Equatable {
  const UnitsState();

  @override
  List<Object?> get props => [];
}

class UnitsInitial extends UnitsState {}

class UnitsLoading extends UnitsState {}

class UnitsLoaded extends UnitsState {
  final List<StudyUnit> units;

  const UnitsLoaded(this.units);

  @override
  List<Object> get props => [units];
}

class UnitsFailure extends UnitsState {
  final String message;

  const UnitsFailure(this.message);

  @override
  List<Object> get props => [message];
}
