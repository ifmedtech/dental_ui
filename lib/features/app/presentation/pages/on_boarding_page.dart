import 'package:dental_ui/core/router/app_route.dart';
import 'package:dental_ui/core/utils/constant/image_constant.dart';
import 'package:dental_ui/core/utils/constant/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Image.asset(
            ImageConstant.onboarding,
            fit: BoxFit.cover,
            width: double.maxFinite,
            height: MediaQuery.sizeOf(context).height * 0.55,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.44,
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  TextConstant.onboarding,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background),
                ),
                Spacer(),
                SizedBox(
                  width: double.maxFinite,
                  child: FilledButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.background)),
                    onPressed: () => context.goNamed(AppRoute.signIn),
                    child: Text(
                      TextConstant.continueT,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
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
