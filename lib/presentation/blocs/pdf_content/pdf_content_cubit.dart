import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/pdf_content.dart';
import '../../../domain/usecases/courses/get_pdf_content_usecase.dart';
import '../../../core/error/failures.dart';

part 'pdf_content_state.dart';

class PdfContentCubit extends Cubit<PdfContentState> {
  final GetPdfContentUseCase _getPdfContentUseCase;

  PdfContentCubit(this._getPdfContentUseCase) : super(PdfContentInitial());

  Future<void> loadPdfContent() async {
    emit(PdfContentLoading());

    final result = await _getPdfContentUseCase(const NoParams());

    result.fold(
      (failure) => emit(PdfContentFailure(_mapFailureToMessage(failure))),
      (pdfContent) => emit(PdfContentLoaded(pdfContent)),
    );
  }

  void clearPdfContent() {
    emit(PdfContentInitial());
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return 'لا يوجد اتصال بالإنترنت';
      case ServerFailure:
        return 'حدث خطأ في الخادم';
      default:
        return 'حدث خطأ غير متوقع';
    }
  }
}
