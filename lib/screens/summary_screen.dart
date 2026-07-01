import 'package:flutter/material.dart';
import 'package:fast_food_pedido/models/product.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final Product product = args["product"];
    final String name = args["name"];
    final String phone = args["phone"];
    final String obs = args["obs"];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumo do Pedido"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),

              const SizedBox(height: 12),

              const Text(
                "Pedido realizado com sucesso!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              /// Card do produto
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          product.imagem,
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        product.nome,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        product.descricao,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),

                      const Divider(height: 30),

                      const Text(
                        "Valor Total",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "R\$ ${product.preco.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Card dos dados do cliente
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Dados do Cliente",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const Divider(),

                      ListTile(
                        leading: const Icon(Icons.person),
                        title: const Text("Nome"),
                        subtitle: Text(name),
                      ),

                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text("Telefone"),
                        subtitle: Text(phone),
                      ),

                      ListTile(
                        leading: const Icon(Icons.edit_note),
                        title: const Text("Observação"),
                        subtitle: Text(
                          obs.isEmpty
                              ? "Nenhuma observação."
                              : obs,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.restaurant_menu),
                  label: const Text(
                    "Voltar ao Cardápio",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      (route) => route.isFirst,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}