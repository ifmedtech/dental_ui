import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    this.body,
    this.appBar,
    this.bottomNavigationBar,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: SafeArea(
        child: body ?? Container(),
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
