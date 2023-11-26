import 'package:m_coffee_v2/src/features/product/domain/model/product.dart';

class Cart {
  Product? product;
  int? quantity;

  Cart({required this.product, this.quantity});
}
