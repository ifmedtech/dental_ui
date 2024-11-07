import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/responsive_utils/responsive_padding.dart';
import '../../../../core/router/app_route.dart';
import '../../../../core/widget/cases_dropdown_widget.dart';
import '../../../../core/widget/cases_search_widget.dart';
import '../../../../core/widget/chart_widget.dart';

class ProgressChartPage extends StatefulWidget {
  const ProgressChartPage({super.key});

  @override
  State<ProgressChartPage> createState() => _ProgressChartPageState();
}

class _ProgressChartPageState extends State<ProgressChartPage> {
  bool isWeeklyPlaque = true;
  bool isWeeklyCavities = true;

  final List<FlSpot> weeklyPlaqueData = [
    FlSpot(0, 1),
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 3),
    FlSpot(5, 4),
    FlSpot(6, 3),
  ];

  final List<FlSpot> monthlyPlaqueData = [
    FlSpot(0, 1),
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 3),
    FlSpot(5, 3),
  ];

  final List<FlSpot> weeklyCavitiesData = [
    FlSpot(0, 2),
    FlSpot(1, 4),
    FlSpot(2, 3),
    FlSpot(3, 6),
    FlSpot(4, 4),
    FlSpot(5, 5),
    FlSpot(6, 4),
  ];

  final List<FlSpot> monthlyCavitiesData = [
    FlSpot(0, 2),
    FlSpot(1, 4),
    FlSpot(2, 3),
    FlSpot(3, 6),
    FlSpot(4, 4),
    FlSpot(5, 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsivePadding.getPadding(context),
      child: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildReportSection(
            context,
            "Plaque Buildup Report",
            weeklyPlaqueData,
            monthlyPlaqueData,
            isWeeklyPlaque,
                (bool isWeekly) {
              setState(() {
                isWeeklyPlaque = isWeekly;
              });
            },
          ),
          _buildReportSection(
            context,
            "Cavities Buildup Report",
            weeklyCavitiesData,
            monthlyCavitiesData,
            isWeeklyCavities,
                (bool isWeekly) {
              setState(() {
                isWeeklyCavities = isWeekly;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: SvgPicture.asset(IconConstant.backIcon, width: 20, height: 20),
              onPressed: () {
                context.goNamed(AppRoute.result);
              },
            ),
            SizedBox(width: 8),
            Expanded(
              child: CasesDropdownWidget(
                caseItems: ['Case Id: 31a', 'Case Id: 30a', 'Case Id: 29a', 'Case Id: 28a'],
                placeholder: 'Select Case Id',
                onChanged: (String selectedCaseId) {
                  print('Selected Case Id: $selectedCaseId');
                },
              ),),
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

  Widget _buildReportSection(
      BuildContext context,
      String reportTitle,
      List<FlSpot> weeklyData,
      List<FlSpot> monthlyData,
      bool isWeekly,
      Function(bool) onToggle,
      ) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReportTitle(context, reportTitle),
            const SizedBox(height: 10),
            //_buildToggleButtons(isWeekly, onToggle),
            const SizedBox(height: 10),
            ChartWidget( // Use the reusable ChartWidget
              weeklyData: weeklyData,
              monthlyData: monthlyData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  // Widget _buildToggleButtons(bool isWeekly, Function(bool) onToggle) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       ChoiceChip(
  //         label: Text(
  //           "Weekly",
  //           style: TextStyle(
  //             color: isWeekly ? ColorUtils.btnColor : Colors.white,
  //           ),
  //         ),
  //         selected: isWeekly,
  //         selectedColor: Colors.white,
  //         backgroundColor: ColorUtils.btnColor,
  //         onSelected: (selected) {
  //           onToggle(true);
  //         },
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //       ),
  //       const SizedBox(width: 8),
  //       ChoiceChip(
  //         label: Text(
  //           "Monthly",
  //           style: TextStyle(
  //             color: !isWeekly ? ColorUtils.btnColor : Colors.white,
  //           ),
  //         ),
  //         selected: !isWeekly,
  //         selectedColor: Colors.white,
  //         backgroundColor: ColorUtils.btnColor,
  //         onSelected: (selected) {
  //           onToggle(false);
  //         },
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(30),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
