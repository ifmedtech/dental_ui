import 'dart:io';
import 'package:pytorch_lite/pytorch_lite.dart';

class DentalAi {
  final File file;
  final int _inputSize = 224;
  final int labelsLength = 3;
  String modelPath = "assets/ai_model/Dental_pytorch_03_12.pt";
  String labelPath = "assets/labels/dental_labels.txt";

  DentalAi({required this.file});

  Future<String> classifyImage() async {
    ClassificationModel classificationModel =
        await PytorchLite.loadClassificationModel(
      modelPath,
      _inputSize,
      _inputSize,
      labelsLength,
      labelPath: labelPath,
    );
    String imagePrediction =
        await classificationModel.getImagePrediction(await file.readAsBytes());

    return imagePrediction;
  }
}
