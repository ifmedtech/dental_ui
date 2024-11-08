import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uvc_camera/flutter_uvc_camera.dart';

part 'capture_image_state.dart';

class CaptureImageCubit extends Cubit<CaptureImageState> {
  //TODO find logic to close camera controller
  final UVCCameraController _cameraController = UVCCameraController();

  CaptureImageCubit() : super(CaptureImageInitial());

  void openCamera() {
    _cameraController.openUVCCamera();
    cameraState();
  }

  void closeCamera() {
    _cameraController.openUVCCamera();
  }

  void captureImage() async {
    try {
      String? path = await _cameraController.takePicture();
      emit(CaptureImageSuccess(path: path!));
    } catch (error) {
      print(error);
    }
  }

  void retake() {
    _cameraController.openUVCCamera();
    emit(CaptureImageInitial());
  }

  UVCCameraController getController() => _cameraController;

  void cameraState() {
    _cameraController.cameraStateCallback = (state) async {
      if (UVCCameraState.opened == state) {
        final allSizes = await _cameraController.getAllPreviewSizes();
        // print(allSizes);
        // cameraController.updateResolution(PreviewSize(
        //   width: (double.maxFinite).toInt(),
        //   height: (MediaQuery.sizeOf(context).height * 0.8).toInt(),
        // ));
      }
    };
  }
}
