import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/constant/icon_constant.dart';
import '../../../../../core/utils/responsive_utils/responsive_padding.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: ResponsivePadding.getPadding(context),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false, // Disable default back button
            flexibleSpace: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leftmost: Back button
                  SvgPicture.asset(IconConstant.backIcon, width: 20, height: 20),

                  SizedBox(width: 10),

                  // Middle: Dropdown menu
                  Expanded(
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300], // Light grey background color for the dropdown
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12), // Padding inside the container
                          child: DropdownButton<String>(
                            isExpanded: true,
                            hint: const Text('Case Id: '),
                            items: ['Option 1', 'Option 2', 'Option 3'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // Handle dropdown selection
                            },
                            // Customized icon
                            icon: SvgPicture.asset(IconConstant.dropDownIcon),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10),

                  // Rightmost: Search bar
                  SizedBox(
                    width: 120, // Width of the search field
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Cases',
                        filled: true,
                        fillColor: Colors.grey[300],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12), // Smaller radius
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8,
                        ), // Reduced padding
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            // Implement search functionality
                            print('Search button clicked');
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Plaque Buildup Report",
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
            )
          ),

          // Rest of the page content
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
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
                              // Row to display the label and 'Case Id' side by side
                              Row(
                                children: [
                                  // New text with grey background
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4), // Adjust padding as needed
                                    color: Colors.grey[300], // Light grey background
                                    child: Text(
                                      'Analysis 31a_4', // Replace with the text you want to show
                                      style: Theme.of(context).textTheme.bodySmall, // Adjust text color if needed
                                    ),
                                  ),
                                  const SizedBox(width: 10), // Add spacing between the new text and 'Case Id'

                                  // 'Case Id: 31a'
                                  SelectableText(
                                    'Case Id: 31a',
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),

                              // Rest of the content
                              SelectableText(
                                '15/10/2024 | 11:35',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SelectableText(
                                'AI Analysis: 2 caries, light plaque buildup.',
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("View Analysis"),
                                      SizedBox(width: 2),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        size: 12,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.download_outlined,
                                    size: 12,
                                  ),
                                ],
                              ),
                            ],

                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
