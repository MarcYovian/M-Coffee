import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/features/cart/domain/model/cart.dart';
import 'package:m_coffee_v2/src/features/product/domain/model/product.dart';

class CartRepository extends ChangeNotifier {
  List<Cart> _cartItems = [];

  List<Cart> get CartItems => _cartItems;

  // add to cart without quantity
  void addToCart(Product product) {
    final existingCartItem =
        _cartItems.indexWhere((item) => item.product?.name == product.name);
    if (existingCartItem != -1) {
      var quantity = _cartItems[existingCartItem].quantity;
      _cartItems[existingCartItem].quantity = quantity! + 1;
    } else {
      _cartItems.add(Cart(product: product, quantity: 1));
    }

    notifyListeners();
  }

  // add to cart with quantity
  void addToCartWithQuantity(Product product, int quantity) {
    final existingCartItem =
        _cartItems.indexWhere((item) => item.product?.name == product.name);
    if (existingCartItem != -1) {
      _cartItems[existingCartItem].quantity =
          _cartItems[existingCartItem].quantity! + quantity;
    } else {
      _cartItems.add(Cart(product: product, quantity: quantity));
    }

    notifyListeners();
  }
}
