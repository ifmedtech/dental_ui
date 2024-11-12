import 'package:dental_ui/core/router/app_route.dart';
import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/widget/custom_scaffold.dart';
import 'package:dental_ui/features/ai_analysis/presentation/cubit/capture_image_cubit/capture_image_cubit.dart';
import 'package:dental_ui/features/ai_analysis/presentation/pages/capture_image_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.body});

  final Widget body;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;

  List<_DashboardTab> homeTabList = const [
    _DashboardTab(IconConstant.overviewTabIcon, 'Overview'),
    _DashboardTab(IconConstant.aiAnalysisTabIcon, 'AI Analysis'),
    _DashboardTab(IconConstant.resultTabIcon, 'Result'),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SvgPicture.asset(
            IconConstant.appIcon,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundColor: ColorUtils.get(context).primary,
              child: Text(
                'A',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: ColorUtils.get(context).surface),
              ),
            ),
          ),
        ],
      ),
      body: widget.body,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: homeTabList.map(
            (e) {
              int i = homeTabList.indexOf(e);
              return InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () => _changeTab(i),
                  child: _getBottomTab(e, i == selectedTab));
            },
          ).toList(),
        ),
      ),
    );
  }

  _getBottomTab(_DashboardTab tab, bool selected) {
    Color _outline = ColorUtils.get(context).outline;
    Color _primary = ColorUtils.get(context).primary;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 15),
        SvgPicture.asset(
          tab.icon,
          colorFilter: ColorFilter.mode(
            selected ? _primary : _outline,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          tab.name,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: selected ? _primary : _outline,
              ),
        ),
      ],
    );
  }

  void _changeTab(int value) {
    switch (value) {
      case 0:
        context.goNamed(AppRoute.overView);
        break;
      case 1:
        {
          context.read<CaptureImageCubit>().openCamera();
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return const CaptureImagePage();
            },
          );
        }
        break;
      case 2:
        context.goNamed(AppRoute.result);
        break;
      default:
        context.goNamed(AppRoute.overView);
        break;
    }
    setState(() {
      selectedTab = value;
    });
  }
}

class _DashboardTab {
  final String icon;
  final String name;

  const _DashboardTab(this.icon, this.name);
}
