import "dart:convert";
import 'package:flutter/services.dart';
import 'package:fast_food_pedido/models/product.dart';

class ProductService {

  // Lê o JSON e retorna uma lista de produtos com tratamento de erros
  Future<List<Product>> loadProducts() async {
    try {
      // Tenta ler o conteúdo do arquivo JSON
      final String response = await rootBundle.loadString('assets/data/products.json');
      
      // Tenta decodificar o JSON
      final List<dynamic> data = jsonDecode(response);

      // Converte e retorna a lista
      return data.map((item) => Product.fromJson(item)).toList();
      
    } catch (error, stackTrace) {
      //Se algo der errado, avisa no console com detalhes do erro
      print('Erro ao carregar ou processar o JSON de produtos: $error');
      print('Stack trace: $stackTrace');
   
      return [];
    }
  }
}