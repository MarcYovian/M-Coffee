import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/common_widgets/horizontal_card_menu.dart';
import 'package:m_coffee_v2/src/features/home/data/home_repository.dart';
import 'package:m_coffee_v2/src/utils/app_utils.dart';

class GridViewCustom extends StatelessWidget {
  const GridViewCustom({super.key});

  @override
  Widget build(BuildContext context) {
    var widthSize = AppUtils.width(context);
    var crossAxisCount = 2;
    if (widthSize > 920) {
      crossAxisCount = 3;
    }

    final RecommendationProducts = HomeRepository.RecommendationProducts();
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: RecommendationProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 175,
        mainAxisSpacing: 5,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => HorizontalCardMenu(
        product: RecommendationProducts[index],
      ),
    );
  }
}
