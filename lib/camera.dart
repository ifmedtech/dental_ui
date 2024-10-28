import 'package:dental_ui/image_prediction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uvc_camera/flutter_uvc_camera.dart';
import 'package:image_picker/image_picker.dart';

class CameraTest extends StatefulWidget {
  const CameraTest({super.key});

  @override
  State<CameraTest> createState() => _CameraTestState();
}

class _CameraTestState extends State<CameraTest> {
  int selectIndex = 0;
  UVCCameraController cameraController = UVCCameraController();

  @override
  void initState() {
    super.initState();
    // cameraController.initializeCamera();
    // cameraController.updateResolution(PreviewSize(
    //   width: MediaQuery.sizeOf(context).width.toInt(),
    //   height: MediaQuery.sizeOf(context).height.toInt(),
    // ));
    cameraController.openUVCCamera();
    cameraState();
    cameraController.msgCallback = (state) {
      showCustomToast(state);
    };
  }

  void cameraState() {
    cameraController.cameraStateCallback = (state) async {
      if (UVCCameraState.opened == state) {
        final allSizes = await cameraController.getAllPreviewSizes();
        // print(allSizes);
        // cameraController.updateResolution(PreviewSize(
        //   width: (double.maxFinite).toInt(),
        //   height: (MediaQuery.sizeOf(context).height * 0.8).toInt(),
        // ));
      }
    };
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void showCustomToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1), // 设置持续时间
      ),
    );
  }

  String videoPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USB Camera Debug Page'),
      ),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: const Text('close'),
                onPressed: () {
                  cameraController.closeCamera();
                },
              ),
              TextButton(
                child: const Text('open'),
                onPressed: () {
                  cameraController.openUVCCamera();
                },
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: UVCCameraView(
              cameraController: cameraController,
              params: const UVCCameraViewParamsEntity(frameFormat: 0),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.tonal(
                  onPressed: () => takePicture(0),
                  child: const Text('Take Picture'),
                ),
                FilledButton.tonal(
                  onPressed: () => picturePicker(),
                  child: const Text('Pick Image'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  takePicture(int i) async {
    String? path = await cameraController.takePicture();

    if (path != null) {
      cameraController.closeCamera();
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => ImagePrediction(
                    imagePath: path,
                  )))
          .then((value) => {cameraController.openUVCCamera()});
    }
  }

  picturePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      cameraController.closeCamera();
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => ImagePrediction(
                    imagePath: image!.path,
                  )))
          .then((value) => {cameraController.openUVCCamera()});
    }
  }
}
