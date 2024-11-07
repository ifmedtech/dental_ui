import 'package:dental_ui/core/widget/cases_id_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:dental_ui/core/utils/responsive_utils/responsive_padding.dart';
import 'package:dental_ui/core/widget/chart_widget.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool isWeekly = true;

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
          CasesAppBarWidget(),
          _buildChartSection(context, isWeekly),
          _buildReportList(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Plaque Buildup Report",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Row(
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
