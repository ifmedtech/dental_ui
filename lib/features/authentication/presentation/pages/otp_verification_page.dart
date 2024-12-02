import 'package:dental_ui/core/router/app_route.dart';
import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/utils/constant/text_constant.dart';
import 'package:dental_ui/core/utils/text_utils.dart';
import 'package:dental_ui/core/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Column(
              children: [
                SvgPicture.asset(IconConstant.appIcon),
                SizedBox(height: 16),
                Text(
                  TextConstant.welcome,
                  style: TextUtils.get(context).displaySmall,
                ),
              ],
            ),
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enter the code send to the number"),
                SizedBox(height: 5),
                Text(
                  "+91 9112916534",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(vertical: 40),
              child: Pinput(
                defaultPinTheme: PinTheme(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: ColorUtils.get(context).primary,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't receive code?"),
                SizedBox(height: 3),
                Text(
                  "Resend",
                  style: TextUtils.get(context).bodyMedium!.copyWith(
                        color: ColorUtils.get(context).primary,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ],
            ),
            Spacer(),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: FilledButton(
                onPressed: () {
                  context.goNamed(AppRoute.overView);
                },
                child: Text("Verify OTP"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
