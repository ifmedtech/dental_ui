import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/color_utils.dart';

class ChartWidget extends StatefulWidget {
  final List<FlSpot> weeklyData;
  final List<FlSpot> monthlyData;

  const ChartWidget({
    Key? key,
    required this.weeklyData,
    required this.monthlyData,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  bool isWeekly = true; // Default to weekly data

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320, // Increased height to accommodate buttons and chart
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: ColorUtils.graphBgColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.05),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: Text(
                  "Weekly",
                  style: TextStyle(
                    color: isWeekly ? ColorUtils.btnColor : Colors.white,
                  ),
                ),
                selected: isWeekly,
                selectedColor: Colors.white,
                backgroundColor: ColorUtils.btnColor,
                onSelected: (selected) {
                  setState(() {
                    isWeekly = true;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide.none,
                ),
                showCheckmark: false,
              ),
              ChoiceChip(
                label: Text(
                  "Monthly",
                  style: TextStyle(
                    color: !isWeekly ? ColorUtils.btnColor : Colors.white,
                  ),
                ),
                selected: !isWeekly,
                selectedColor: Colors.white,
                backgroundColor: ColorUtils.btnColor,
                onSelected: (selected) {
                  setState(() {
                    isWeekly = false;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide.none,
                ),
                showCheckmark: false,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: isWeekly ? widget.weeklyData : widget.monthlyData,
                    isCurved: true,
                    color: ColorUtils.white,
                    barWidth: 4,
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        if (isWeekly) {
                          const daysOfWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              daysOfWeek[value.toInt() % 7],
                              style: TextStyle(color: ColorUtils.white),
                            ),
                          );
                        } else {
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              months[value.toInt() % 6],
                              style: TextStyle(color: ColorUtils.white),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                lineTouchData: LineTouchData(enabled: false),
                extraLinesData: ExtraLinesData(
                  verticalLines: [
                    for (var spot in (isWeekly ? widget.weeklyData : widget.monthlyData))
                      VerticalLine(
                        x: spot.x, // Position of the vertical line
                        color: ColorUtils.white, // Color of the vertical line
                        strokeWidth: 2, // Width of the vertical line
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
