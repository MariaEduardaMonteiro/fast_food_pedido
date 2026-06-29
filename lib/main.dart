import 'package:flutter/material.dart';
import 'package:fast_food_pedido/models/product.dart';
import 'package:fast_food_pedido/screens/home_screen.dart';
import 'package:fast_food_pedido/screens/order_screen.dart';
import 'package:fast_food_pedido/screens/summary_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Express',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/summary': (context) => const SummaryScreen(),
      },
      //Adicionamos onGenerateRoute para lidar com telas que precisam de parâmetros obrigatórios via construtor
      onGenerateRoute: (settings) {
        if (settings.name == '/order') {
          final product = settings.arguments as Product;
          return MaterialPageRoute(
            builder: (context) => OrderScreen(product: product),
          );
        }
        return null;
      },
    );
  }
}