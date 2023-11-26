import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/common_widgets/vertical_card_menu.dart';
import 'package:m_coffee_v2/src/features/home/data/home_repository.dart';

class HorizontalList extends StatelessWidget {
  const HorizontalList({super.key});

  @override
  Widget build(BuildContext context) {
    final newProducts = HomeRepository.newProducts();

    return Expanded(
      child: ListView.builder(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: newProducts.length,
        itemBuilder: (context, index) =>
            VerticalCardMenu(product: newProducts[index]),
      ),
    );
  }
}
