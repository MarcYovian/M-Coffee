import 'package:flutter/widgets.dart';
import 'package:m_coffee_v2/src/features/product/domain/model/product.dart';

class ProductRepository {
  static List<Product> ListProduct = [
    Product(
      image: "americano.jpg",
      name: "Americano",
      category: "Coffee",
      price: 19000,
      discount: 10,
      rating: 4.7,
      numOfSales: 1000,
      description:
          const Text("Espresso yang dicampur dengan air mineral (tanpa gula)."),
      timestamp: DateTime(2023, 10, 24),
    ),
    Product(
      image: "cappucino.jpeg",
      name: "Cappucino",
      category: "Coffee",
      price: 19000,
      discount: 0,
      rating: 3.8,
      numOfSales: 900,
      description: const Text("Espresso dengan fresh milk."),
      timestamp: DateTime(2023, 9, 24),
    ),
    Product(
      image: "Korean-Fried-Chicken.jpg",
      name: "Korean Fried Chicken",
      category: "Rice",
      price: 25200,
      discount: 6,
      rating: 4.2,
      numOfSales: 900,
      description: const Text("Ayam pokpok dengan saus ala korea."),
      timestamp: DateTime(2023, 10, 24),
    ),
    Product(
      image: "salt-egg-chicken.jpg",
      name: "Chicken Salted Egg",
      category: "Rice",
      price: 26900,
      discount: 3,
      rating: 3.7,
      numOfSales: 74,
      description: const Text(
          "Nasi putih pulen dan wangi yang disajikan dengan ayam pok pok bertabur saus telur asin"),
      timestamp: DateTime(2023, 10, 29),
    ),
    Product(
      image: "carbonara.jpg",
      name: "Carbonara",
      category: "Spaghetti",
      price: 26900,
      discount: 10,
      rating: 4.5,
      numOfSales: 100,
      description: const Text(
          "Spaghetti creamy dan gurih dengan potongan ham dan sosis serta keju di atasnya."),
      timestamp: DateTime(2023, 8, 29),
    ),
    Product(
      image: "korean-ramyun.jpeg",
      name: "korean-ramyun",
      category: "Noddle",
      price: 24600,
      discount: 15,
      rating: 4.1,
      numOfSales: 23,
      description: const Text(
          "Mie kuah pedas ala Korea dengan berbagai topping seperti telur, sosis, dan ham"),
      timestamp: DateTime(2023, 8, 29),
    ),
  ];
}
