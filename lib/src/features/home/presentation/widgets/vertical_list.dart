import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/common_widgets/horizontal_card_menu.dart';
import 'package:m_coffee_v2/src/features/home/data/home_repository.dart';

class VerticalList extends StatelessWidget {
  const VerticalList({super.key});

  @override
  Widget build(BuildContext context) {
    final RecommendationProducts = HomeRepository.RecommendationProducts();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: RecommendationProducts.length,
      itemBuilder: (context, index) => HorizontalCardMenu(
        product: RecommendationProducts[index],
      ),
    );
  }
}
