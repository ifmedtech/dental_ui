
import 'package:tflite_flutter/tflite_flutter.dart';

class DentalAi {
  late List<int> inputShape;
  late List<int> outputShape;

  late TfLiteType inputType;
  late TfLiteType outputType;

  late Interpreter interpreter;

  List<String> classificationLabels = ['Caries', 'Plaque'];

  DentalAi() {
    initModel();
  }

  Future<void> initModel() async {
    interpreter = await Interpreter.fromAsset(
        'ai_model/dental_classification_model.tflite');

    inputShape = interpreter.getInputTensor(0).shape;
    outputShape = interpreter.getOutputTensor(0).shape;

    print('Input shape: $inputShape');
    print('Output shape: $outputShape');

    // #3
    // inputType = interpreter.getInputTensor(0).type;
    // outputType = interpreter.getOutputTensor(0).type;
  }

  // Future<TensorImage> _preProcessImage(File imageFile) async {
  //   var image = img.decodeImage(imageFile.readAsBytesSync())!;
  //
  //   final inputTensor = TensorImage(inputType);
  //   inputTensor.loadImage(image);
  //
  //   // #2
  //   final minLength = min(inputTensor.height, inputTensor.width);
  //   final cropOp = ResizeWithCropOrPadOp(minLength, minLength);
  //
  //   // #3
  //   final shapeLength = inputShape[1];
  //   final resizeOp = ResizeOp(shapeLength, shapeLength, ResizeMethod.BILINEAR);
  //
  //   // #4
  //   final normalizeOp = NormalizeOp(127.5, 127.5);
  //
  //   // #5
  //   final imageProcessor = ImageProcessorBuilder()
  //       .add(cropOp)
  //       .add(resizeOp)
  //       .add(normalizeOp)
  //       .build();
  //
  //   imageProcessor.process(inputTensor);
  //
  //   debugPrint(
  //     'Pre-processed image: ${inputTensor.width}x${image.height}, '
  //     'size: ${inputTensor.buffer.lengthInBytes} bytes',
  //   );
  //   // #6
  //   return inputTensor;
  // }

  // Future<ClassifierCategory> predict(File imageFile) async {
  //   final inputImage = await _preProcessImage(imageFile);
  //
  //   // TODO: run TF Lite
  //   // #1
  //   final outputBuffer = TensorBuffer.createFixedSize(
  //     outputShape,
  //     outputType,
  //   );
  //
  //   // #2
  //   interpreter.run(inputImage.buffer, outputBuffer.buffer);
  //   debugPrint('OutputBuffer: ${outputBuffer.getDoubleList()}');
  //
  //   // TODO: _postProcessOutput
  //   // Post Process the outputBuffer
  //   final resultCategories = _postProcessOutput(outputBuffer);
  //   final topResult = resultCategories.first;
  //
  //   debugPrint('Top category: $topResult');
  //
  //   return topResult;
  // }
  //
  // List<ClassifierCategory> _postProcessOutput(TensorBuffer outputBuffer) {
  //   // #1
  //   final probabilityProcessor = TensorProcessorBuilder().build();
  //
  //   probabilityProcessor.process(outputBuffer);
  //
  //   // #2
  //   final labelledResult =
  //       TensorLabel.fromList(classificationLabels, outputBuffer);
  //
  //   // #3
  //   final categoryList = <ClassifierCategory>[];
  //   labelledResult.getMapWithFloatValue().forEach((key, value) {
  //     final category = ClassifierCategory(key, value);
  //     categoryList.add(category);
  //     debugPrint('label: ${category.label}, score: ${category.score}');
  //   });
  //
  //   // #4
  //   categoryList.sort((a, b) => (b.score > a.score ? 1 : -1));
  //
  //   return categoryList;
  // }
}
