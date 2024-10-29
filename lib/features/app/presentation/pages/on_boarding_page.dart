import 'package:dental_ui/core/utils/constant/image_constant.dart';
import 'package:dental_ui/core/utils/constant/text_constant.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            ImageConstant.onboarding,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  TextConstant.onboarding,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: FilledButton(
                    onPressed: () {},
                    child: Text(TextConstant.continueT),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
