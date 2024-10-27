import 'dart:io';
import 'package:dental_ui/main.dart';
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
  String? img;
  UVCCameraController cameraController = UVCCameraController();

  @override
  void initState() {
    super.initState();
    cameraController.msgCallback = (state) {
      showCustomToast(state);
    };
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text('close'),
                  onPressed: () {
                    cameraController.closeCamera();
                    setState(() {});
                  },
                ),
                TextButton(
                  child: const Text('open'),
                  onPressed: () {
                    cameraController.openUVCCamera();
                    cameraController.updateResolution(
                      PreviewSize(
                        width: MediaQuery.sizeOf(context).width.toInt(),
                        height:
                            (MediaQuery.sizeOf(context).height * 0.6).toInt(),
                      ),
                    );
                    setState(() {});
                  },
                ),
              ],
            ),
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
              child: Text('Take Picture'),
            ),
            FilledButton.tonal(
              onPressed: () => picturePicker(),
              child: const Text('Pick Image'),
            ),
            if (img != null)
              SizedBox(
                height: 100,
                width: 100,
                child: Image.file(File(img!)),
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
              builder: (context) => HomePage(
                    imagePath: path,
                  )))
          .then((value) => {cameraController.openUVCCamera()});
      img = path;
      print("Image path is ");
      setState(() {});
    }
  }

  captureVideo(int i) async {
    String? path = await cameraController.captureVideo();
    if (path != null) {
      videoPath = path;
      setState(() {});
    }
  }

  picturePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      cameraController.closeCamera();
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => HomePage(
                    imagePath: image!.path,
                  )))
          .then((value) => {cameraController.openUVCCamera()});
      img = image?.path;
      print("Image path is ");
      setState(() {});
    }
  }
}
