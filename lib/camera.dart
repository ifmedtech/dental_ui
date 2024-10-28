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
    cameraController.msgCallback = (state) {
      showCustomToast(state);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: UVCCameraView(
                cameraController: cameraController,
                params: const UVCCameraViewParamsEntity(frameFormat: 0),
                width: double.maxFinite,
                height: MediaQuery.sizeOf(context).height * 0.6,
              ),
            ),
            SizedBox(height: 10),
            FilledButton.tonal(
              onPressed: () => takePicture(0),
              child: const Text('Take Picture'),
            ),
            FilledButton.tonal(
              onPressed: () => picturePicker(),
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 100)
          ],
        ),
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
