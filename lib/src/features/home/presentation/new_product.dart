import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/features/home/presentation/widgets/horizontal_list.dart';
import 'package:m_coffee_v2/src/utils/app_utils.dart';

class NewProducts extends StatelessWidget {
  const NewProducts({super.key});

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
                "New Menu",
                style: TextStyle(
                  fontSize: titleFontSize.toDouble(),
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFC6011),
                ),
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
        const SizedBox(
          height: 300,
          child: Row(
            children: [
              HorizontalList(),
            ],
          ),
        ),
      ],
    );
  }
}
