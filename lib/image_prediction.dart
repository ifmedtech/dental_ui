import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

class ImagePrediction extends StatefulWidget {
  const ImagePrediction({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<ImagePrediction> createState() => _ImagePredictionState();
}

class _ImagePredictionState extends State<ImagePrediction> {
  late File file;
  String modelResult = "";
  final List<String> _classNames = ['Caries', 'Plaque'];

  @override
  void initState() {
    print(widget.imagePath);
    file = File(widget.imagePath);
    classifyImage(file, 224, _classNames);
    super.initState();
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

  Future<Uint8List> loadAndPreprocessImage(
      File imageFile, int inputSize) async {
    Uint8List imageData = await imageFile.readAsBytes();
    img.Image? image = img.decodeImage(imageData);
    img.Image resizedImage =
        img.copyResize(image!, width: inputSize, height: inputSize);
    var input = Float32List(inputSize * inputSize * 3);
    var pixelIndex = 0;

    for (var y = 0; y < inputSize; y++) {
      for (var x = 0; x < inputSize; x++) {
        var pixel = resizedImage.getPixel(x, y);
        input[pixelIndex++] = img.getRed(pixel) / 255.0; // Normalize to [0, 1]
        input[pixelIndex++] = img.getGreen(pixel) / 255.0;
        input[pixelIndex++] = img.getBlue(pixel) / 255.0;
      }
    }

    return input.buffer.asUint8List(); // Return preprocessed image as Uint8List
  }

  Future<List<Map<String, dynamic>>> classifyImage(
      File imageFile, int inputSize, List<String> labels) async {
    final interpreter = await Interpreter.fromAsset(
        'assets/ai_model/dental_classification_model.tflite');

    var input = await loadAndPreprocessImage(imageFile, inputSize);

    var output = List.filled(labels.length, 0.0).reshape([1, labels.length]);

    interpreter.run(input, output);

    interpreter.close();

    List<Map<String, dynamic>> predictions = [];
    for (int i = 0; i < labels.length; i++) {
      predictions.add({
        'label': labels[i],
        'confidence': output[0][i] // Confidence score for each class
      });
      modelResult = "$modelResult${labels[i]} : ${output[0][i]}\n";
    }

    predictions.sort((a, b) => b['confidence'].compareTo(a['confidence']));
    setState(() {});
    return predictions; // Returns sorted predictions with confidence scores
  }
}
