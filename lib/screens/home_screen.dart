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

  Future<void> _reloadProducts() async {
    setState(() {
      productsFuture = service.loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food Express",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: productsFuture,
        builder: (context, snapshot) {

          // Carregando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Erro
          if (snapshot.hasError) {
            return const Center(
              child: Text("Erro ao carregar o cardápio"),
            );
          }

          // Dados carregados
          if (snapshot.hasData) {
            final products = snapshot.data!;

            return RefreshIndicator(
              onRefresh: _reloadProducts,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [

                  const Text(
                    "🍔 Bem-vindo!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Escolha seu lanche favorito.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Cardápio",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...products.map(
                    (product) => ProductCard(
                      product: product,
                      onAdd: () {
                        Navigator.pushNamed(
                          context,
                          '/order',
                          arguments: product,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text("Nenhum produto encontrado."),
          );
        },
      ),
    );
  }
}