import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/constants/app_constants.dart';

class StarRating extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color starColor;

  StarRating(
      {required this.rating,
      this.starSize = 25.0,
      this.starColor = AppConstants.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating.round() ? Icons.star : Icons.star_border,
          size: starSize,
          color: starColor,
        );
      }),
    );
  }
}
