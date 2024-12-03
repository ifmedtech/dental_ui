import 'dart:io';

import 'package:dental_ui/core/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

class PytorchTest extends StatefulWidget {
  const PytorchTest({super.key});

  @override
  State<PytorchTest> createState() => _PytorchTestState();
}

class _PytorchTestState extends State<PytorchTest> {
  XFile? image;
  String? prediction;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text("PyTorch"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
              onPressed: () async {
                final ImagePicker picker = ImagePicker();
                image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  _predict();
                }
              },
              child: Text("Pick Image")),
          Container(
            width: double.maxFinite,
            height: 300,
            child: image != null
                ? Image.file(File(image!.path), fit: BoxFit.fill)
                : null,
          ),
          Text('Output - $prediction')
        ],
      ),
    );
  }

  void _predict() async {
    ClassificationModel classificationModel =
        await PytorchLite.loadClassificationModel(
            "assets/ai_model/Dental_pytorch_03_12.pt", 224, 224, 3,
            labelPath: "assets/labels/dental_labels.txt");
    String imagePrediction = await classificationModel
        .getImagePrediction(await File(image!.path).readAsBytes());
    setState(() {
      prediction = imagePrediction;
    });
  }
}
