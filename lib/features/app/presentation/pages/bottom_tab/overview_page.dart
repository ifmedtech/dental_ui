import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/utils/responsive_utils/responsive_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsivePadding.getPadding(context),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            // floating: true,
            // snap: true,
            toolbarHeight: 40,
            flexibleSpace: FlexibleSpaceBar(
              background: FilledButton(
                onPressed: () {},
                child: const Text('Connect the device'),
              ),
            ),
          ),
          SliverAppBar(
            expandedHeight: 210,
            floating: true,
            snap: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "AI Analysis",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 120,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: ColorUtils.get(context).primary.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Start your AI Analysis",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: ColorUtils.get(context).surface),
                              ),
                              Text(
                                "Keep Track of your oral health, click here to start.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: ColorUtils.get(context).surface),
                              ),
                              Text(
                                "Last Analysis : 02/10/2024",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: ColorUtils.get(context).surface),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: SvgPicture.asset(
                            IconConstant.scanIcon,
                            colorFilter: ColorFilter.mode(
                                ColorUtils.get(context).surface,
                                BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Past Analysis",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("View More"),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 12,
                    )
                  ],
                )
              ],
            ),
          ),
          SliverList.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Container(
              height: 200,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.05),
              ),
              child: Column(
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
