import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uvc_camera/flutter_uvc_camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

part 'capture_image_state.dart';

class CaptureImageCubit extends Cubit<CaptureImageState> {
  //TODO find logic to close camera controller
  final UVCCameraController _cameraController = UVCCameraController();
  UVCCameraState uvcCameraState = UVCCameraState.closed;

  CaptureImageCubit() : super(CaptureImageInitial()) {
    cameraState();
  }

  void openCamera() {
    _cameraController.openUVCCamera();
    Future.delayed(const Duration(microseconds: 100), () {
      emit(CameraOpenState(uvcCameraController: _cameraController));
    });
  }

  void closeCamera() {
    if (uvcCameraState == UVCCameraState.opened) {
      _cameraController.closeCamera();
    }
  }

  void permission() {}

  void backButton(BuildContext context) {
    closeCamera();
    context.pop();
  }

  void captureImage() async {
    try {
      String? path = await _cameraController.takePicture();
      closeCamera();
      emit(CaptureImageSuccess(path: path!));
    } catch (error) {
      print(error);
    }
  }

  void retake() {
    openCamera();
    emit(CaptureImageInitial());
  }

  UVCCameraController getController() => _cameraController;

  void cameraState() {
    _cameraController.cameraStateCallback = (state) async {
      uvcCameraState = state;
      if (UVCCameraState.opened == state) {
        final allSizes = await _cameraController.getAllPreviewSizes();
        Fluttertoast.showToast(msg: state.name);
        // print(allSizes);
        // cameraController.updateResolution(PreviewSize(
        //   width: (double.maxFinite).toInt(),
        //   height: (MediaQuery.sizeOf(context).height * 0.8).toInt(),
        // ));
      }
    };
  }
}
