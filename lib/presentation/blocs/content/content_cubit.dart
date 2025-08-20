import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/unit_content.dart';
import '../../../domain/usecases/courses/get_unit_content_usecase.dart';
import '../../../core/error/failures.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  final GetUnitContentUseCase _getUnitContentUseCase;

  ContentCubit(this._getUnitContentUseCase) : super(ContentInitial());

  Future<void> loadUnitContent(int unitId) async {
    emit(ContentLoading());

    final result = await _getUnitContentUseCase(GetUnitContentParams(unitId: unitId));

    result.fold(
      (failure) => emit(ContentFailure(_mapFailureToMessage(failure))),
      (unitContent) => emit(ContentLoaded(unitContent)),
    );
  }

  void clearContent() {
    emit(ContentInitial());
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
