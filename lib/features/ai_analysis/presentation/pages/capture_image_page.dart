import 'dart:io';

import 'package:dental_ui/core/router/app_route.dart';
import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/widget/custom_scaffold.dart';
import 'package:dental_ui/features/ai_analysis/presentation/cubit/capture_image_cubit/capture_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_uvc_camera/flutter_uvc_camera.dart';
import 'package:go_router/go_router.dart';

class CaptureImagePage extends StatefulWidget {
  const CaptureImagePage({super.key});

  @override
  State<CaptureImagePage> createState() => _CaptureImagePageState();
}

class _CaptureImagePageState extends State<CaptureImagePage> {
  @override
  void initState() {
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
            child: BlocBuilder<CaptureImageCubit, CaptureImageState>(
              builder: (context, state) {
                if (state is CaptureImageSuccess) {
                  return Image.file(File(state.path));
                }
                if (state is CameraOpenState) {
                  return UVCCameraView(
                    cameraController: state.uvcCameraController,
                    params: const UVCCameraViewParamsEntity(frameFormat: 0),
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height,
                  );
                }
                return const CircularProgressIndicator.adaptive();
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 19,
            right: 19,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<CaptureImageCubit, CaptureImageState>(
                  builder: (context, state) {
                    if (state is! CaptureImageSuccess) {
                      return InkWell(
                        onTap: () {
                          context.read<CaptureImageCubit>().backButton(context);
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
                      );
                    } else {
                      return const SizedBox(width: 54, height: 55);
                    }
                  },
                ),
                captureScannerButton(),
                BlocBuilder<CaptureImageCubit, CaptureImageState>(
                  builder: (context, state) {
                    if (state is CaptureImageSuccess) {
                      return InkWell(
                        onTap: () => context.read<CaptureImageCubit>().retake(),
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
                      );
                    } else {
                      return SizedBox(width: 54, height: 55);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder<CaptureImageCubit, CaptureImageState> captureScannerButton() {
    return BlocBuilder<CaptureImageCubit, CaptureImageState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            print(state);
            if (state is CaptureImageSuccess) {
              context.pop();
              context.goNamed(AppRoute.aiAnalysis,
                  queryParameters: {'imagePath': state.path});
            } else {
              context.read<CaptureImageCubit>().captureImage();
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
            child: state is CaptureImageSuccess
                ? SvgPicture.asset(IconConstant.scanner)
                : SvgPicture.asset(IconConstant.camera),
          ),
        );
      },
    );
  }
}
