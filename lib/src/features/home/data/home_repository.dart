import 'package:m_coffee_v2/src/features/product/data/product_repository.dart';

class HomeRepository {
  static String userName = "Marcellinus Yovian";

  // Product release less than 1 month
  static List newProducts() {
    final DateTime oneWeekAgo =
        DateTime.now().subtract(const Duration(days: 30));
    return ProductRepository.ListProduct.where((product) =>
            product.timestamp != null && product.timestamp!.isAfter(oneWeekAgo))
        .toList();
  }

  // Rating more than 4.2
  static List RecommendationProducts() {
    return ProductRepository.ListProduct.where(
        (product) => product.rating != null && product.rating! >= 4.2).toList();
  }
}
