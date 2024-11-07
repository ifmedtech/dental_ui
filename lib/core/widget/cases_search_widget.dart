import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';

class CasesSearchWidget extends StatelessWidget {
  final void Function()? onSearchPressed;

  const CasesSearchWidget({
    Key? key,
    this.onSearchPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 115,
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Cases',
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              IconConstant.searchIcon,
              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
            onPressed: onSearchPressed ?? () {
              print('Search button clicked');
            },
          ),
        ),
      ),
    );
  }
}
