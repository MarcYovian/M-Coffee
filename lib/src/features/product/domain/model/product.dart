import 'package:flutter/widgets.dart';

class Product {
  String? image;
  String? name;
  String? category;
  double? price;
  double? discount;
  double? rating;
  int? numOfSales;
  Text? description;
  DateTime? timestamp;

  Product({
    required this.image,
    required this.name,
    required this.price,
    this.category,
    this.discount,
    this.rating,
    this.numOfSales,
    this.description,
    required this.timestamp,
  });
}
