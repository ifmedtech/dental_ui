import 'package:dental_ui/core/router/app_route.dart';
import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/utils/constant/image_constant.dart';
import 'package:dental_ui/core/utils/constant/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.onBoarding,
      body: Column(
        children: [
          Image.asset(
            ImageConstant.onboarding,
            fit: BoxFit.fill,
            width: double.maxFinite,
            height: MediaQuery.sizeOf(context).height * 0.53,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.44,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 58,
                  height: 58,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorUtils.get(context).background,
                  ),
                  child: SvgPicture.asset(IconConstant.appIcon),
                ),
                Text(
                  TextConstant.onboarding,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: ColorUtils.get(context).background,
                      ),
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: FilledButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).colorScheme.background)),
                    onPressed: () => context.goNamed(AppRoute.mobileNumber),
                    child: Text(
                      TextConstant.continueT,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
