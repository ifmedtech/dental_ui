import 'package:dental_ui/core/utils/color_utils.dart';
import 'package:dental_ui/core/utils/responsive_utils/responsive_padding.dart';
import 'package:flutter/material.dart';

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
            expandedHeight: 10,
            flexibleSpace: FlexibleSpaceBar(
              background: FilledButton(
                onPressed: () {},
                child: const Text('Connect the device'),
              ),
            ),
          ),
          SliverAppBar(
              expandedHeight: 250,
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
                      height: 150,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color:
                              ColorUtils.get(context).primary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Column(
                            children: [],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
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
          )
        ],
      ),
    );
  }
}
