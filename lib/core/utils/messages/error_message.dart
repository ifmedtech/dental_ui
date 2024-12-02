

import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:flutter/material.dart';

class ErrorMessage{
  static scaffold(BuildContext context,String? message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorUtils.get(context).error,
        content: Text(
            message??"Contact support team for more help"),
      ),
    );
  }
}