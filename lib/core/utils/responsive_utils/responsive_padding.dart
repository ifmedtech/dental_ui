
import 'package:flutter/material.dart';

class ResponsivePadding {
  // Define a base padding value
  static const double basePadding = 16.0;

  // Calculate padding based on screen width
  static EdgeInsets getPadding(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // You can adjust the scaling factor as needed
    if (screenWidth >= 1200) {
      return const EdgeInsets.all(basePadding * 2); // Larger screens
    } else if (screenWidth >= 800) {
      return const EdgeInsets.all(basePadding * 1.5); // Medium screens
    } else {
      return const EdgeInsets.all(basePadding); // Small screens (default)
    }
  }
}
