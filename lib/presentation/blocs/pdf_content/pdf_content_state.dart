part of 'pdf_content_cubit.dart';

abstract class PdfContentState extends Equatable {
  const PdfContentState();

  @override
  List<Object?> get props => [];
}

class PdfContentInitial extends PdfContentState {}

class PdfContentLoading extends PdfContentState {}

class PdfContentLoaded extends PdfContentState {
  final PdfContentResponse pdfContent;

  const PdfContentLoaded(this.pdfContent);

  @override
  List<Object?> get props => [pdfContent];
}

class PdfContentFailure extends PdfContentState {
  final String message;

  const PdfContentFailure(this.message);

  @override
  List<Object?> get props => [message];
}


