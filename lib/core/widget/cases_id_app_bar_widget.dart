import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cases_dropdown_widget.dart';  // Make sure to import your CasesDropdownWidget
import 'cases_search_widget.dart';    // Make sure to import your CasesSearchWidget
import 'package:dental_ui/core/utils/constant/icon_constant.dart';         // Import your icon constants if needed

class CasesAppBarWidget extends StatelessWidget {
  const CasesAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(IconConstant.backIcon, width: 20, height: 20),
            SizedBox(width: 8),
            Expanded(
              child: CasesDropdownWidget(
                caseItems: ['Case Id: 31a', 'Case Id: 30a', 'Case Id: 29a', 'Case Id: 28a'],
                placeholder: 'Select Case Id',
                onChanged: (String selectedCaseId) {
                  print('Selected Case Id: $selectedCaseId');
                },
              ),
            ),
            SizedBox(width: 8),
            CasesSearchWidget(
              onSearchPressed: () {
                // Custom search action, if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}
