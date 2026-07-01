import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fast_food_pedido/models/product.dart';

class OrderScreen extends StatefulWidget {
  final Product product;

  const OrderScreen({
    super.key,
    required this.product,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController obsController = TextEditingController();

  bool _isButtonEnabled = false;

  void _checkFormValidity() {
    final isNameValid = nameController.text.trim().isNotEmpty;
    final isPhoneValid = phoneController.text.trim().length >= 10;

    setState(() {
      _isButtonEnabled = isNameValid && isPhoneValid;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    obsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pedido"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              /// Card do Produto
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
                          color: Colors.grey[700],
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "R\$ ${product.preco.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// Campo Nome
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (_) => _checkFormValidity(),
              ),

              const SizedBox(height: 16),

              /// Campo Telefone
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  labelText: "Telefone",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                onChanged: (_) => _checkFormValidity(),
              ),

              const SizedBox(height: 16),

              /// Campo Observação
              TextField(
                controller: obsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Observação",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit_note),
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isButtonEnabled
                      ? () {
                          Navigator.pushNamed(
                            context,
                            "/summary",
                            arguments: {
                              "product": product,
                              "name": nameController.text,
                              "phone": phoneController.text,
                              "obs": obsController.text,
                            },
                          );
                        }
                      : null,
                  icon: const Icon(Icons.shopping_cart_checkout),
                  label: const Text(
                    "Finalizar Pedido",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}