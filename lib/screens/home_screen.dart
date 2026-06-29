import 'package:fast_food_pedido/screens/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:fast_food_pedido/models/product.dart';
import 'package:fast_food_pedido/services/product_service.dart';
import 'package:fast_food_pedido/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductService service = ProductService();

  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = service.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cardápio", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {
          
          //Carregando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          //Erro
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar o cardápio"),
            );
          }

          //Dados carregados
          if (snapshot.hasData) {
            final products = snapshot.data!;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                  return ProductCard(
                    product: product,
                    onAdd: () {
                      Navigator.pushNamed(
                        context,
                        '/order',
                        arguments: product, // Passamos o produto como argumento aqui
                      );
                    },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}