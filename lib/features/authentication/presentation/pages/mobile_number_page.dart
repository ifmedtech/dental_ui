import 'package:dental_ui/core/router/app_route.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/utils/constant/text_constant.dart';
import 'package:dental_ui/core/utils/text_utils.dart';
import 'package:dental_ui/core/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MobileNumberPage extends StatefulWidget {
  const MobileNumberPage({super.key});

  @override
  State<MobileNumberPage> createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
            Column(
              children: [
                Text(
                  'Enter Your Mobile number',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text("We will send you a Confirmation Code"),
                SizedBox(height: 30),
                Container(
                  // width: 200,
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //     bottom: BorderSide(
                  //       color: ColorUtils.get(context).primary,
                  //     ),
                  //   ),
                  // ),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 42),
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: FilledButton(
                onPressed: () {
                  context.goNamed(AppRoute.otpVerification);
                },
                child: Text("Get OTP"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
