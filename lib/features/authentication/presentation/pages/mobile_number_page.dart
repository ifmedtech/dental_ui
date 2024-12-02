import 'package:dental_ui/core/utils/loading/loading_dialog.dart';
import 'package:dental_ui/core/utils/messages/error_message.dart';
import 'package:dental_ui/features/authentication/presentation/cubit/get_otp/get_otp_cubit.dart';
import 'package:dental_ui/router/app_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/utils/constant/text_constant.dart';
import 'package:dental_ui/core/utils/text_utils.dart';
import 'package:dental_ui/core/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MobileNumberPage extends StatefulWidget {
  const MobileNumberPage({super.key});

  @override
  State<MobileNumberPage> createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  final TextEditingController _mobileNumber = TextEditingController();

  @override
  void dispose() {
    _mobileNumber.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetOtpCubit, GetOtpState>(
      listener: (context, state) {
        if (state is GetOtpLoading) {
          LoadingDialog.showOnPageLoading(context);
        } else if (state is GetOtpSuccess) {
          LoadingDialog.hideOnPageLoading(context);
          context.goNamed(AppRoute.otpVerification);
        } else if (state is GetOtpError) {
          ErrorMessage.scaffold(context, state.errorMessage);
          LoadingDialog.hideOnPageLoading(context);
        }
      },
      child: CustomScaffold(
        body: Form(
          key: _formKey,
          child: Container(
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
                        controller: _mobileNumber,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          String _pattern = r'(^(?:[+0]9)?[0-9]{10,10}$)';
                          RegExp regExp = RegExp(_pattern);

                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          } else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid mobile number';
                          }
                          return null;
                        },
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
                      if (_formKey.currentState!.validate()) {
                        context.read<GetOtpCubit>().call(_mobileNumber.text);
                      }
                    },
                    child: Text("Get OTP"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
