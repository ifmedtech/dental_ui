import 'dart:io';
import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/widget/custom_scaffold.dart';
import 'package:dental_ui/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_uvc_camera/flutter_uvc_camera.dart';
import 'package:go_router/go_router.dart';

class CaptureImagePage extends StatefulWidget {
  const CaptureImagePage({super.key});

  @override
  State<CaptureImagePage> createState() => _CaptureImagePageState();
}

class _CaptureImagePageState extends State<CaptureImagePage> {
  UVCCameraController? cameraController;
  String? imagePath;

  @override
  void initState() {
    cameraController = UVCCameraController();
    cameraController?.msgCallback = (state) {
      // showCustomToast(state);
    };
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Container(
            color: ColorUtils.get(context).shadow,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: cameraController != null
                ? imagePath != null
                    ? Image.file(File(imagePath!))
                    : UVCCameraView(
                        cameraController: cameraController!,
                        params: const UVCCameraViewParamsEntity(frameFormat: 0),
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                      )
                : null,
          ),
          Positioned(
            bottom: 20,
            left: 19,
            right: 19,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    width: 54,
                    height: 55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ColorUtils.get(context).surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: ColorUtils.get(context).primary,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (imagePath != null) {
                      Navigator.of(context, rootNavigator: true).pop();
                      context.goNamed(AppRoute.aiAnalysis,
                          queryParameters: {'imagePath': imagePath});
                    } else {
                      imagePath = await cameraController?.takePicture();
                      if (imagePath != null) {
                        setState(() {});
                      }
                    }
                  },
                  child: Container(
                    width: 77,
                    height: 76,
                    decoration: BoxDecoration(
                      color: ColorUtils.get(context).surface,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: imagePath != null
                        ? SvgPicture.asset(IconConstant.scanner)
                        : SvgPicture.asset(IconConstant.camera),
                  ),
                ),
                if (imagePath != null)
                  InkWell(
                    onTap: () {
                      setState(() {
                        imagePath = null;
                      });
                    },
                    child: Container(
                      width: 54,
                      height: 55,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: ColorUtils.get(context).surface,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(IconConstant.retake),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
