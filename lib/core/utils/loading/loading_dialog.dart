import 'package:flutter/material.dart';

class LoadingDialog {
  static hideOnPageLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static showOnPageLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Please Wait"),
              ],
            ),
          ),
        );
      },
    );
  }
}
