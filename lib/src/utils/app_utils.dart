import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static MediaQueryData mediaQueryData(BuildContext context) {
    return MediaQuery.of(context);
  }

  static double width(BuildContext context) {
    return mediaQueryData(context).size.width;
  }

  static double height(BuildContext context) {
    return mediaQueryData(context).size.height;
  }

  static String formattedPrice(double Price) {
    final NumberFormat currencyFormat =
        NumberFormat.currency(locale: "id", symbol: "Rp", decimalDigits: 0);
    return currencyFormat.format(Price);
  }
}
