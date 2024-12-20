import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/constant/icon_constant.dart';
import 'package:dental_ui/core/utils/responsive_utils/responsive_padding.dart';
import 'package:dental_ui/core/utils/text_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            surfaceTintColor: ColorUtils.get(context).background,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "AI Analysis",
                    style: TextUtils.get(context).headlineMedium,
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
                                style: TextUtils.get(context)
                                    .titleLarge!
                                    .copyWith(
                                        color:
                                            ColorUtils.get(context).background),
                              ),
                              Text(
                                "Keep Track of your oral health, click here to start.",
                                style: TextUtils.get(context)
                                    .bodyMedium!
                                    .copyWith(
                                        color:
                                            ColorUtils.get(context).background),
                              ),
                              Text(
                                "Last Analysis : 02/10/2024",
                                style: TextUtils.get(context)
                                    .bodySmall!
                                    .copyWith(
                                        color:
                                            ColorUtils.get(context).background),
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
                  style: TextUtils.get(context).titleLarge,
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
              height: 160,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 0.05),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: double.maxFinite,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          'assets/images/sample.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            'Case Id: 31a',
                            style: TextUtils.get(context).bodyMedium,
                          ),
                          SelectableText(
                            '15/10/2024 | 11:35',
                            style: TextUtils.get(context).titleMedium,
                          ),
                          SelectableText(
                            'AI Analysis : 2 caries , light plaque buildup.',
                          ),
                          Container(
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "View Analysis",
                                      style: TextUtils.get(context).bodySmall,
                                    ),
                                    SizedBox(width: 2),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 12,
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  IconConstant.downloadIcon,
                                  height: 12,
                                  colorFilter: ColorFilter.mode(
                                      ColorUtils.get(context).onBackground,
                                      BlendMode.srcIn),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
