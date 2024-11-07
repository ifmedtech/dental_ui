import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/router/app_route.dart';
import '../../../../../core/utils/constant/icon_constant.dart';
import '../../../../../core/utils/responsive_utils/responsive_padding.dart';
import '../../../../../core/widget/cases_dropdown_widget.dart';
import '../../../../../core/widget/chart_widget.dart';
import '../../../../../core/widget/cases_search_widget.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool isWeekly = true;
  String selectedOption = 'Option 1';

  // Sample data for weekly and monthly
  final List<FlSpot> weeklyData = [
    FlSpot(0, 1),
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 3),
    FlSpot(5, 4),
    FlSpot(6, 3),
  ];

  final List<FlSpot> monthlyData = [
    FlSpot(0, 1),  // January
    FlSpot(1, 3),  // February
    FlSpot(2, 2),  // March
    FlSpot(3, 5),  // April
    FlSpot(4, 3),  // May
    FlSpot(5, 3),  // June
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsivePadding.getPadding(context),
      child: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildChartSection(context, isWeekly),
          _buildReportList(),
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

  Widget _buildDropdownMenu() {
    // Initialize the selected value with the placeholder
    String selectedValue = 'Select Case Id'; // Initial value as the placeholder

    return Center(
      child: DropdownButtonHideUnderline(
        child: Container(
          decoration: BoxDecoration(
            color: ColorUtils.searchBoxColor,
            borderRadius: BorderRadius.circular(52), // Outer container with rounded corners
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8), // Reduced padding
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedValue == 'Select Case Id' ? null : selectedValue, // Handle placeholder separately
            hint: Text(
              selectedValue, // Default placeholder text
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.black, // Hint text color
              ),
            ),
            items: ['Case Id: 31a', 'Case Id: 30a', 'Case Id: 29a', 'Case Id: 28a'].map((String value) {
              return DropdownMenuItem<String>(
                value: selectedValue,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorUtils.white, // Default background color for items
                  ),
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black, // Text color
                    ),
                  ),
                ),
              );
            }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue!;
                });
              },
            icon: SvgPicture.asset(
              IconConstant.dropDownIcon,
              width: 20, // Custom icon size
              height: 20, // Custom icon size
            ),
            selectedItemBuilder: (BuildContext context) {
              return [
                for (var item in ['Case Id: 31a', 'Case Id: 30a', 'Case Id: 29a', 'Case Id: 28a'])
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black, // Text color of selected item
                      ),
                    ),
                  ),
              ];
            },
            // Limit the height to show only 3 items
            menuMaxHeight: 120, // 40px height per item * 3 = 120px max height
          ),
        ),
      ),
    );
  }

  // Widget _buildSearchField() {
  //   return SizedBox(
  //     width: 115,
  //     child: TextField(
  //       decoration: InputDecoration(
  //         labelText: 'Cases',
  //         filled: true,
  //         fillColor: ColorUtils.searchBoxColor,
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(32),
  //           borderSide: BorderSide.none,
  //         ),
  //         contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
  //         suffixIcon: IconButton(
  //           icon: SvgPicture.asset(
  //             IconConstant.searchIcon,
  //             colorFilter: ColorFilter.mode(ColorUtils.black, BlendMode.srcIn),
  //           ),
  //           onPressed: () {
  //             print('Search button clicked');
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Plaque Buildup Report",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        GestureDetector(
          onTap: () => context.goNamed(AppRoute.progressChart), // Navigate to progress_chart.dart
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Progress Chart",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 5),
              const Icon(Icons.arrow_forward_ios_outlined, size: 12),
            ],
          ),
        ),
      ],
    );
  }
  Widget _buildChartSection(BuildContext context, bool isWeekly) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(context),
            const SizedBox(height: 10),
            // Now using the isWeekly parameter
            ChartWidget(
              weeklyData: weeklyData,
              monthlyData: monthlyData,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildToggleButtons() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     children: [
  //       ChoiceChip(
  //         label: const Text("Weekly"),
  //         selected: isWeekly,
  //         onSelected: (selected) {
  //           setState(() {
  //             isWeekly = true;
  //           });
  //         },
  //       ),
  //       const SizedBox(width: 8),
  //       ChoiceChip(
  //         label: const Text("Monthly"),
  //         selected: !isWeekly,
  //         onSelected: (selected) {
  //           setState(() {
  //             isWeekly = false;
  //           });
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildLineChart() {
  //   return Container(
  //     height: 280, // Increased height to accommodate buttons and prevent clipping
  //     margin: const EdgeInsets.symmetric(vertical: 10),
  //     decoration: BoxDecoration(
  //       color: ColorUtils.graphBgColor,
  //       borderRadius: BorderRadius.circular(10),
  //       border: Border.all(width: 0.05),
  //     ),
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Increased horizontal padding
  //     child: Column(
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             ChoiceChip(
  //               label: Text(
  //                 "Weekly",
  //                 style: TextStyle(
  //                   color: isWeekly ? ColorUtils.btnColor : Colors.white, // Change text color based on selection
  //                 ),
  //               ),
  //               selected: isWeekly,
  //               selectedColor: Colors.white, // Background color when selected
  //               backgroundColor: ColorUtils.btnColor, // Background color when not selected
  //               onSelected: (selected) {
  //                 setState(() {
  //                   isWeekly = true; // Set to true for Weekly
  //                 });
  //               },
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(30), // Rounded corners
  //                 side: BorderSide.none, // Remove the border
  //               ),
  //               showCheckmark: false,
  //             ),
  //             ChoiceChip(
  //               label: Text(
  //                 "Monthly",
  //                 style: TextStyle(
  //                   color: !isWeekly ? ColorUtils.btnColor : Colors.white, // Change text color based on selection
  //                 ),
  //               ),
  //               selected: !isWeekly,
  //               selectedColor: Colors.white, // Background color when selected
  //               backgroundColor: ColorUtils.btnColor, // Background color when not selected
  //               onSelected: (selected) {
  //                 setState(() {
  //                   isWeekly = false; // Set to false for Monthly
  //                 });
  //               },
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(30), // Rounded corners
  //                 side: BorderSide.none, // Remove the border
  //               ),
  //               showCheckmark: false,
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 10),
  //         Expanded(
  //           child: LineChart(
  //             LineChartData(
  //               lineBarsData: [
  //                 // The main line graph
  //                 LineChartBarData(
  //                   spots: isWeekly ? weeklyData : monthlyData,
  //                   isCurved: true,
  //                   color: ColorUtils.white,
  //                   barWidth: 4,
  //                 ),
  //               ],
  //               titlesData: FlTitlesData(
  //                 leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hide left titles
  //                 rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hide right titles
  //                 topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hide top titles
  //                 bottomTitles: AxisTitles(
  //                   sideTitles: SideTitles(
  //                     showTitles: true,
  //                     interval: 1, // Show one label per spot
  //                     reservedSize: 30, // Add reserved size to prevent clipping
  //                     getTitlesWidget: (value, meta) {
  //                       if (isWeekly) {
  //                         // Labels for weekly view (7 days)
  //                         const daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  //                         return SideTitleWidget(
  //                           axisSide: meta.axisSide,
  //                           child: Text(daysOfWeek[value.toInt() % 7],
  //                             style: TextStyle(color: ColorUtils.white),
  //                           ),
  //                         );
  //                       } else {
  //                         // Labels for monthly view (6 months)
  //                         const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
  //                         return SideTitleWidget(
  //                           axisSide: meta.axisSide,
  //                           child: Text(
  //                             months[value.toInt() % 6],
  //                             style: TextStyle(color: ColorUtils.white),  // Ensure ColorUtils.white is defined
  //                           ),
  //                         );
  //                       }
  //                     },
  //                   ),
  //                 ),
  //               ),
  //               gridData: FlGridData(show: false),
  //               borderData: FlBorderData(
  //                 show: false,
  //                 border: const Border(
  //                   left: BorderSide(color: Colors.grey),
  //                   bottom: BorderSide(color: Colors.grey),
  //                 ),
  //               ),
  //               // Add vertical lines at each data point (x = day or month)
  //               lineTouchData: LineTouchData(enabled: false), // Disable touch interactions
  //               extraLinesData: ExtraLinesData(
  //                 verticalLines: [
  //                   // Create vertical lines at the exact data points' x values
  //                   for (var spot in (isWeekly ? weeklyData : monthlyData))
  //                     VerticalLine(
  //                       x: spot.x,  // Position of the vertical line
  //                       color: ColorUtils.white,  // Color of the vertical line
  //                       strokeWidth: 2,  // Width of the line
  //                     ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildReportList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return _buildReportCard();
        },
        childCount: 5,
      ),
    );
  }

  Widget _buildReportCard() {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.05),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/sample.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        color: Colors.grey[300],
                        child: Text(
                          'Analysis 31a_4',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SelectableText(
                        'Case Id: 31a',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  SelectableText(
                    '15/10/2024 | 11:35',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SelectableText('AI Analysis: 2 caries, light plaque buildup.'),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("View Analysis"),
                          SizedBox(width: 2),
                          Icon(Icons.arrow_forward_ios_outlined, size: 12),
                        ],
                      ),
                      Icon(Icons.download_outlined, size: 12),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
