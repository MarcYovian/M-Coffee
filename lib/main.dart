import 'package:flutter/material.dart';
import 'package:m_coffee_v2/src/features/cart/data/cart_repository.dart';
import 'package:m_coffee_v2/src/routing/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartRepository(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.init,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
