import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

class DentalAi {
  final File file;
  final List<String> _classNames = ['Caries', 'Normal Teeth', 'Plaque'];
  final int _inputSize = 180;

  DentalAi({required this.file});

  Future<String> classifyImage() async {
    String modelResult = '';
    final interpreter =
        await Interpreter.fromAsset('assets/ai_model/Latest_Dental_TF.tflite');

    var input = await preprocessImage();

    var output =
        List.filled(_classNames.length, 0.0).reshape([1, _classNames.length]);

    interpreter.run(input, output);

    interpreter.close();

    double maxValue = 0.0;
    for (int i = 0; i < _classNames.length; i++) {
      if (output[0][i] > maxValue) {
        maxValue = output[0][i];
        modelResult = _classNames[i];
      }
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

    // for (var y = 0; y < _inputSize; y++) {
    //   for (var x = 0; x < _inputSize; x++) {
    //     var pixel = resizedImage.getPixel(x, y);
    //     input[pixelIndex++] = img.getRed(pixel).toDouble();
    //     input[pixelIndex++] = img.getGreen(pixel).toDouble();
    //     input[pixelIndex++] = img.getBlue(pixel).toDouble();
    //   }
    // }
    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        int pixel = image.getPixel(j, i) as int;
        // Extract RGBA components from pixel value
        int r = (pixel >> 24) & 0xFF;
        int g = (pixel >> 16) & 0xFF;
        int b = (pixel >> 8) & 0xFF;

        // Normalize and store pixel values
        input[pixelIndex++] = r.toDouble();
        input[pixelIndex++] = g.toDouble();
        input[pixelIndex++] = b.toDouble();

        // buffer[pixelIndex++] = (imglib.getRed(pixel) - 128) / 128;
        // buffer[pixelIndex++] = (imglib.getGreen(pixel) - 128) / 128;
        // buffer[pixelIndex++] = (imglib.getBlue(pixel) - 128) / 128;
      }
    }

    return input.buffer.asUint8List();
  }
}
