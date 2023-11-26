import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/features/home/presentation/widgets/grid.dart';
import 'package:m_coffee_v2/src/features/home/presentation/widgets/vertical_list.dart';
import 'package:m_coffee_v2/src/utils/app_utils.dart';

class RecommendationsProducts extends StatelessWidget {
  const RecommendationsProducts({super.key});

  @override
  Widget build(BuildContext context) {
    double width = AppUtils.width(context);
    double height = AppUtils.height(context);

    var titleFontSize = 0;
    if (height > 600) {
      titleFontSize = 26;
    } else if (height < 600) {
      titleFontSize = 20;
    }

    if (width < 300) {
      titleFontSize = 20;
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recommendations",
                style: TextStyle(
                    fontSize: titleFontSize.toDouble(),
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFC6011)),
              ),
              if (width > 310)
                Text(
                  "See all",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: width < 630 ? VerticalList() : GridViewCustom(),
        ),
      ],
    );
  }
}
