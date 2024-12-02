import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/text_constant.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/utils/text_utils.dart';
import 'package:dental_ui/core/widget/custom_scaffold.dart';
import 'package:dental_ui/router/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
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
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _textFieldColumnWidget(
                    "Email",
                    TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter email',
                      ),
                    ),
                  ),
                  SizedBox(height: 17),
                  _textFieldColumnWidget(
                    "Password",
                    TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter password',
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: ColorUtils.get(context).primary),
                    ),
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: FilledButton(
                      onPressed: () {
                        context.goNamed(AppRoute.overView);
                      },
                      child: const Text("Sign In"),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextUtils.get(context).bodyMedium!.copyWith(
                      color: ColorUtils.get(context).onBackground,
                    ),
                children: [
                  TextSpan(
                    text: 'Sign up',
                    style: TextUtils.get(context).titleSmall!.copyWith(
                          color: ColorUtils.get(context).primary,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _textFieldColumnWidget(String label, TextFormField textFormField) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextUtils.get(context).titleSmall,
        ),
        const SizedBox(height: 2),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: textFormField,
        ),
      ],
    );
  }
}
