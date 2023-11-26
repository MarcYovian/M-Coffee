import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:m_coffee_v2/src/constants/api_constants.dart';

class ApiClient {
  static const String apiUrl = ApiConstants.baseUrl;

  static Future<List<Products>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Products> listProducts = List<Products>.from(
          data['data'].map((productData) => Products.fromJson(productData)));
      // print(listProducts[1].name);
      return listProducts;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<void> addProducts(Products newProduct) async {
    final response = await http.post(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'name': newProduct.name,
      'image': newProduct.image,
      'price': newProduct.price.toString(),
      'discount': newProduct.discount.toString(),
      'description': newProduct.description,
      'rating': newProduct.rating.toString(),
      'numOfSales': newProduct.numOfSales.toString(),
      'category': newProduct.category,
    });

    final Map<String, dynamic> data = json.decode(response.body);
    final int statusCode = data['code'];
    print(statusCode);
    if (statusCode == 201) {
      // Kode 201 menunjukkan bahwa permintaan berhasil
      print('Product added successfully!');
    } else {
      // Kode selain 201 menunjukkan bahwa ada kesalahan
      final String errorMessage = data['message'];
      print(errorMessage);
    }
  }

  static Future<void> UpdateProducts(Products newProduct) async {
    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'id': newProduct.id,
        'name': newProduct.name,
        'image': newProduct.image,
        'price': newProduct.price.toString(),
        'discount': newProduct.discount.toString(),
        'description': newProduct.description,
        'rating': newProduct.rating.toString(),
        'numOfSales': newProduct.numOfSales.toString(),
        'category': newProduct.category,
      },
    );

    final Map<String, dynamic> data = json.decode(response.body);
    final int statusCode = data['code'];
    final String message = data['message'];
    print(statusCode);
    if (statusCode == 201) {
      // Kode 201 menunjukkan bahwa permintaan berhasil
      print(message);
    } else {
      // Kode selain 201 menunjukkan bahwa ada kesalahan
      print(message);
    }
  }

  static Future<void> deleteData(String id) async {
    final response = await http.delete(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'id': id},
    );

    final Map<String, dynamic> data = json.decode(response.body);
    final int statusCode = data['code'];

    if (statusCode == 200) {
      print(data['message']);
    } else {
      print(data['message']);
    }
  }
}

class Products {
  String? id;
  final String name;
  final String image;
  final int price;
  final int discount;
  final String description;
  final double rating;
  final int numOfSales;
  final String category;
  String? createdAt;
  String? updatedAt;

  Products({
    this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.discount,
    required this.description,
    required this.rating,
    required this.numOfSales,
    required this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: int.parse(json['price']),
      discount: int.parse(json['discount']),
      description: json['description'],
      rating: double.parse(json['rating']),
      numOfSales: int.parse(json['numOfSales']),
      category: json['category'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price.toString(),
      'discount': discount.toString(),
      'description': description,
      'rating': rating.toString(),
      'numOfSales': numOfSales.toString(),
      'category': category,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
