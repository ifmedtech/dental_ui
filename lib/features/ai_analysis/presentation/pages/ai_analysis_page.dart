import 'dart:io';

import 'package:dental_ui/features/dental_ai/dental_ai.dart';
import 'package:flutter/material.dart';
import 'package:dental_ui/core/utils/responsive_utils/responsive_padding.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_ui/router/app_route.dart';
import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:image_picker/image_picker.dart';

class AiAnalysisPage extends StatefulWidget {
  const AiAnalysisPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  State<AiAnalysisPage> createState() => _AiAnalysisPageState();
}

class _AiAnalysisPageState extends State<AiAnalysisPage> {
  String? prediction;

  late String imagePath;

  @override
  void initState() {
    imagePath = widget.imagePath;
    super.initState();
    processModel();
  }

  processModel() async {
    var dentalAi = DentalAi(file: File(widget.imagePath));
    prediction = await dentalAi.classifyImage();
    setState(() {});
  }

  picturePicker() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image?.path != null) {
      var dentalAi = DentalAi(file: File(image!.path));
      prediction = await dentalAi.classifyImage();
      imagePath = image.path;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsivePadding.getPadding(context),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 800,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 3),
                  const Text(
                    "16/10/2024 | 12:35",
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 300,
                    width: double.maxFinite,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: () => picturePicker(),
                    child: const Text("Pick Image"),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 0.05),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(height: 50),
                                      Text(
                                        "Analysis Results",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      const SizedBox(width: 5),
                                      SvgPicture.asset(
                                          IconConstant.questionMarkIcon),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              // Center for aligning the second row of containers
                              Container(
                                height: 80,
                                decoration: BoxDecoration(
                                  color: ColorUtils.resultsLow,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "$prediction Found",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: 5,
                                              // Line thickness
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error, // red
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 5,
                                              // Line thickness
                                              color: Colors.green, //green
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Vertical space between the Row and the buttons
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            // Minimize the Row's width to fit its children
                            children: [
                              FilledButton(
                                onPressed: () =>
                                    _saveResultBottomSheet(context),
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Rounded corners
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        IconConstant.saveResultsIcon),
                                    // The icon
                                    const SizedBox(width: 5),
                                    // Space between the icon and text
                                    const Text('Save Results'),
                                    // The text
                                  ],
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Horizontal space between the buttons
                              FilledButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // Rounded corners
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        IconConstant.retakePhotoIcon),
                                    // The icon
                                    const SizedBox(width: 5),
                                    // Space between the icon and text
                                    const Text('Retake Photo'),
                                    // The text
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// This function opens the custom bottom sheet
void _saveResultBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows the sheet to be scrollable
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        // Reduced padding to decrease height
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'New Case',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            // Reduced space between heading and input

            // Case ID Field and Button
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 140, // Reduced width of the text field
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Case ID',
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // Slightly smaller border radius
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10), // Reduced padding
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      icon: SvgPicture.asset(
                        IconConstant
                            .autoGenerateIcon, // Ensure this constant points to your SVG icon
                      ),
                      onPressed: () {
                        // Implement your retake photo functionality here
                        print("Auto Generate button clicked!");
                      },
                    ),
                    Text(
                      'Auto Generate', // The text next to the icon
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ],
            ),

            // Another Heading with Search Field
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Previous Cases',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: 140, // Reduced width of the search field
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cases',
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.5),
                      //grey
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        // Smaller radius
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      // Reduced padding
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search), // Use the search icon
                        onPressed: () {
                          // Implement search functionality
                          print('Search button clicked');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Reduced space between fields

            // Scrollable Area
            SizedBox(
              height: 160, // Reduced height of the scrollable area
              child: Container(
                padding: const EdgeInsets.all(8),
                // Same padding as the analysis section
                margin: const EdgeInsets.only(top: 10),
                // Adjust margin as needed
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.surface, // Background color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outlineVariant
                          .withOpacity(0.5),
                      width: 1), // Border styling
                ),
                child: Scrollbar(
                  // Add this widget to show the scrollbar
                  thumbVisibility: true,
                  // Ensures the scrollbar is visible when scrolling
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(5, (index) {
                        bool isFirstItem =
                            index == 0; // Check if this is the first item

                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          // Reduced margin between items
                          padding: const EdgeInsets.all(6),
                          // Reduced padding inside each item
                          decoration: BoxDecoration(
                            //color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: isFirstItem
                                ? [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outlineVariant
                                          .withOpacity(0.5),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                            border: isFirstItem
                                ? Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .outlineVariant
                                        .withOpacity(0.5),
                                    width: 2)
                                : Border.all(color: ColorUtils.transparent),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Case ID: $index'),
                              Text(
                                '15-10-2024 | 13:06',
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6),
            // Reduced space before the buttons

            // Button to save the results
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // Minimize the Row's width to fit its children
                children: [
                  FilledButton(
                    onPressed: () {
                      // Navigate to the Save Results Page when clicked
                      Navigator.pop(context); // Close the bottom sheet
                      context.goNamed(
                          AppRoute.result); // Navigate to the Save Results Page
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Smaller border radius
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12)),
                      // Reduced padding
                      minimumSize: MaterialStateProperty.all(
                          Size(90, 36)), // Set minimum size for the button
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconConstant.saveResultsIcon),
                        // The icon
                        const SizedBox(width: 4),
                        // Space between the icon and text
                        const Text('Save Results'),
                        // The text
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Horizontal space between the buttons
                  OutlinedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Smaller border radius
                        ),
                      ),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Set the border color
                          width: 2, // Set the border width
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 6, horizontal: 12)),
                      // Reduced padding
                      minimumSize: MaterialStateProperty.all(
                          Size(90, 36)), // Set minimum size for the button
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconConstant.downloadIcon),
                        // The icon
                        const SizedBox(width: 4),
                        // Space between the icon and text
                        const Text('Download Analysis'),
                        // The text
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
