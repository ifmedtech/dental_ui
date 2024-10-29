import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class DentalAi {
  final File file;
  final List<String> _classNames = ['Caries', 'Plaque'];
  final int _inputSize = 224;

  DentalAi({required this.file});

  Future<String> classifyImage() async {
    String modelResult = '';
    final interpreter = await Interpreter.fromAsset(
        'assets/ai_model/dental_classification_model.tflite');

    var input = await preprocessImage();

    var output =
        List.filled(_classNames.length, 0.0).reshape([1, _classNames.length]);

    interpreter.run(input, output);

    interpreter.close();

    List<Map<String, dynamic>> predictions = [];
    for (int i = 0; i < _classNames.length; i++) {
      predictions.add({
        'label': _classNames[i],
        'confidence': output[0][i] // Confidence score for each class
      });
      modelResult = "$modelResult${_classNames[i]} : ${output[0][i]}\n";
    }

    return modelResult;
  }

  Future<Uint8List> preprocessImage() async {
    Uint8List imageData = await file.readAsBytes();
    img.Image? image = img.decodeImage(imageData);
    img.Image resizedImage =
        img.copyResize(image!, width: _inputSize, height: _inputSize);
    var input = Float32List(_inputSize * _inputSize * 3);
    var pixelIndex = 0;

    for (var y = 0; y < _inputSize; y++) {
      for (var x = 0; x < _inputSize; x++) {
        var pixel = resizedImage.getPixel(x, y);
        input[pixelIndex++] = img.getRed(pixel) / 255.0; 
        input[pixelIndex++] = img.getGreen(pixel) / 255.0;
        input[pixelIndex++] = img.getBlue(pixel) / 255.0;
      }
    }

    return input.buffer.asUint8List();
  }
}
