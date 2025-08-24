import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/pdf_content.dart';
import '../../repositories/course_repository.dart';

class GetPdfContentUseCase implements UseCase<PdfContentResponse, NoParams> {
  final CourseRepository repository;

  GetPdfContentUseCase(this.repository);

  @override
  Future<Either<Failure, PdfContentResponse>> call(NoParams params) async {
    return await repository.getPdfContent();
  }
}

class NoParams {
  const NoParams();
}
