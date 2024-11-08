part of 'capture_image_cubit.dart';

sealed class CaptureImageState extends Equatable {
  const CaptureImageState();
}

final class CaptureImageInitial extends CaptureImageState {
  @override
  List<Object> get props => [];
}

final class CaptureImageSuccess extends CaptureImageState {
  final String path;

  const CaptureImageSuccess({required this.path});

  @override
  List<Object> get props => [];
}
