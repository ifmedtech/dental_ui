import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';

class CasesDropdownWidget extends StatefulWidget {
  final List<String> caseItems;
  final String placeholder;
  final Function(String) onChanged;

  const CasesDropdownWidget({
    Key? key,
    required this.caseItems,
    this.placeholder = 'Select Case Id',
    required this.onChanged,
  }) : super(key: key);

  @override
  _CasesDropdownWidgetState createState() => _CasesDropdownWidgetState();
}

class _CasesDropdownWidgetState extends State<CasesDropdownWidget> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.searchBoxColor,
            borderRadius: BorderRadius.circular(52),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedValue == widget.placeholder ? null : selectedValue,
            hint: Text(
              widget.placeholder,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black,
              ),
            ),
            items: widget.caseItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorUtils.white,
                  ),
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue;
              });
              widget.onChanged(newValue!); // Trigger the callback with the selected value
            },
            icon: SvgPicture.asset(
              IconConstant.dropDownIcon,
              width: 20,
              height: 20,
            ),
            selectedItemBuilder: (BuildContext context) {
              return widget.caseItems.map((String value) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList();
            },
            menuMaxHeight: 120,
          ),
        ),
      ),
    );
  }
}
