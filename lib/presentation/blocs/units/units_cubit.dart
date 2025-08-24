import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/study_unit.dart';
import '../../../domain/usecases/courses/get_units_usecase.dart';
import '../../../core/error/failures.dart';

part 'units_state.dart';

class UnitsCubit extends Cubit<UnitsState> {
  final GetUnitsUseCase _getUnitsUseCase;

  UnitsCubit(this._getUnitsUseCase) : super(UnitsInitial());

  Future<void> loadUnits(int subjectId) async {
    emit(UnitsLoading());

    final result = await _getUnitsUseCase(GetUnitsParams(subjectId: subjectId));

    result.fold(
      (failure) => emit(UnitsFailure(_mapFailureToMessage(failure))),
      (units) => emit(UnitsLoaded(units)),
    );
  }

  void clearUnits() {
    emit(UnitsInitial());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'No internet connection';
      case ServerFailure:
        return 'Server error occurred';
      default:
        return 'An unexpected error occurred';
    }
  }
}
