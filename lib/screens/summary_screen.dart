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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Pedido realizado!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Text("Produto: ${product.nome}"),
            Text("Preço: R\$ ${product.preco.toStringAsFixed(2)}"),

            const SizedBox(height: 12),

            Text("Nome: $name"),
            Text("Telefone: $phone"),
            Text("Observação: $obs"),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text("Voltar ao Cardápio"),
              ),
            )
          ],
        ),
      ),
    );
  }
}