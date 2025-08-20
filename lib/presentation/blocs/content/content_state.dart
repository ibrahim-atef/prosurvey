part of 'content_cubit.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object?> get props => [];
}

class ContentInitial extends ContentState {}

class ContentLoading extends ContentState {}

class ContentLoaded extends ContentState {
  final UnitContent unitContent;

  const ContentLoaded(this.unitContent);

  @override
  List<Object> get props => [unitContent];
}

class ContentFailure extends ContentState {
  final String message;

  const ContentFailure(this.message);

  @override
  List<Object> get props => [message];
}
