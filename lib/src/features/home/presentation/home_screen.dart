import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:m_coffee_v2/src/features/cart/data/cart_repository.dart';
import 'package:m_coffee_v2/src/features/home/presentation/new_product.dart';
import 'package:m_coffee_v2/src/features/home/presentation/recommendation.dart';
import 'package:m_coffee_v2/src/features/home/presentation/widgets/app_bar.dart';
import 'package:m_coffee_v2/src/utils/app_utils.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = AppUtils.height(context);
    print(Provider.of<CartRepository>(context).CartItems.length);

    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: height / 5,
            child: HomeAppBar(),
          ),
          Gap(10),
          NewProducts(),
          Gap(10),
          RecommendationsProducts(),
        ],
      ),
    );
  }
}
