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

  //Variável para controlar se o botão deve estar ativo
  bool _isButtonEnabled = false;

  //Função que verifica se os campos obrigatórios estão preenchidos
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Produto selecionado
            Text(
              product.nome,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "R\$ ${product.preco.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20),

            // Nome
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Nome",
                border: OutlineInputBorder(),
              ),
              //Dispara a verificação a cada letra digitada
              onChanged: (_) => _checkFormValidity(),
            ),

            const SizedBox(height: 12),

            // Telefone
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: "Telefone",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              //Garante que apenas números sejam digitados
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (_) => _checkFormValidity(),
            ),

            const SizedBox(height: 12),

            // Observação
            TextField(
              controller: obsController,
              decoration: const InputDecoration(
                labelText: "Observação",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),

            const Spacer(),

            //Botão para finalizar compra
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                //Se '_isButtonEnabled' for falso, passamos null no onPressed
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
                child: const Text(
                  "Finalizar Pedido",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}