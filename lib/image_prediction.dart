import 'dart:io';
import 'package:dental_ui/feature/dental_ai/dental_ai.dart';
import 'package:flutter/material.dart';

class ImagePrediction extends StatefulWidget {
  const ImagePrediction({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<ImagePrediction> createState() => _ImagePredictionState();
}

class _ImagePredictionState extends State<ImagePrediction> {
  late File file;
  String modelResult = "";

  @override
  void initState() {
    initModel();
    super.initState();
  }

  void initModel() async {
    file = File(widget.imagePath);

    //TODO : Add state management code
    final dentalAi = DentalAi(file: file);
    modelResult = await dentalAi.classifyImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: Image.file(file),
          ),
          Text(
            modelResult,
            textAlign: TextAlign.center,
          ),
          Text(
            widget.imagePath,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
