import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dental_ui/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CameraTest(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late File file;
  String modelResult = "";
  final int _inputSize = 224;
  final List<String> _classNames = ['Caries', 'Plaque'];

  @override
  void initState() {
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
          Image.file(file),
          Text(modelResult ?? "Processing image"),
        ],
      ),
    );
  }

  // void openImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     file = File(image.path);
  //     setState(() {});
  //     classifyImage(file!);
  //   }
  // }
  Future<Uint8List> loadAndPreprocessImage(
      File imageFile, int inputSize) async {
    // Read the file as bytes
    Uint8List imageData = await imageFile.readAsBytes();

    // Decode the image using the 'image' package
    img.Image? image = img.decodeImage(imageData);

    // Resize the image to the model's expected input size (e.g., 224x224)
    img.Image resizedImage =
        img.copyResize(image!, width: inputSize, height: inputSize);

    // Convert image to a normalized 1D Float32List array as model input
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
