# fast_food_pedido

Aplicação mobile desenvolvida em Flutter para visualização de cardápio e realização de pedidos de forma simples e intuitiva.

Este projeto foi construído como parte de um **teste técnico de processo seletivo**, com foco em organização de código, componentização, experiência do usuário e boas práticas de desenvolvimento.

---

## Funcionalidades

### Cardápio Dinâmico
- Listagem de produtos carregados localmente via arquivo JSON (`assets/data/products.json`)
- Exibição de imagem, nome, descrição e preço de cada item
- Carregamento assíncrono com `FutureBuilder`, incluindo estados de *loading* e erro

### Realização de Pedido
- Seleção de produto a partir do cardápio
- Formulário com:
  - Nome
  - Telefone (com máscara e validação)
  - Observação (opcional)

### Validação Inteligente
- Botão "Finalizar Pedido" habilitado apenas quando os dados são válidos
- Validação de telefone com 10 ou 11 dígitos numéricos
- Máscara de formatação automática no campo de telefone (`(##) #####-####`) via `mask_text_input_formatter`

### Resumo do Pedido
- Confirmação visual de pedido realizado com sucesso
- Exibição do produto selecionado (imagem, nome, descrição e valor total)
- Dados do cliente (nome, telefone e observação)
- Botão para retornar ao cardápio, limpando a pilha de navegação

### Tratamento de Erros
- Controle de exceções no carregamento do JSON para evitar falhas na aplicação

---

## Tecnologias Utilizadas

- Flutter / Dart
- `StatefulWidget` e `StatelessWidget` (gerenciamento de estado local)
- `FutureBuilder` (consumo de dados assíncronos)
- Navegação com rotas nomeadas (`routes` e `onGenerateRoute`)
- Componentização de UI (`ProductCard` reutilizável)
- Validação de formulários
- `mask_text_input_formatter` (máscara de telefone)
- JSON local como fonte de dados (`rootBundle` + `dart:convert`)

---

## Estrutura do Projeto

```text
lib/
├── models/
│   └── product.dart              # Modelo de dados do produto (Product + fromJson)
│
├── screens/
│   ├── home_screen.dart          # Tela do cardápio
│   ├── order_screen.dart         # Tela de pedido com formulário
│   └── summary_screen.dart       # Tela de resumo do pedido
│
├── services/
│   └── product_service.dart      # Leitura e tratamento do JSON de produtos
│
├── widgets/
│   └── product_card.dart         # Componente reutilizável de produto (card na listagem)
│
└── main.dart                     # Configuração de rotas e inicialização do app

assets/
├── data/
│   └── products.json             # Base de dados local dos produtos do cardápio
└── images/
    └── ...                       # Imagens dos produtos
```

---

## Fluxo de Navegação

| Rota        | Tela            | Como é chamada                                  |
|-------------|------------------|--------------------------------------------------|
| `/`         | `HomeScreen`     | Rota inicial do app                               |
| `/order`    | `OrderScreen`    | `onGenerateRoute`, recebendo um `Product` como argumento |
| `/summary`  | `SummaryScreen`  | `Navigator.pushNamed`, recebendo um `Map` com produto, nome, telefone e observação |

O retorno ao cardápio a partir da tela de resumo é feito com `Navigator.popUntil(context, (route) => route.isFirst)`.

---

## Modelo de Dados

```dart
class Product {
  final int id;
  final String nome;
  final String descricao;
  final double preco;
  final String imagem;
}
```

Exemplo de item em `products.json`:

```json
{
  "id": 1,
  "nome": "X-frango",
  "descricao": "Pão, frango em cubos, mussarela, batata palha",
  "preco": 18.00,
  "imagem": "assets/images/xfrango.jpg"
}
```

O cardápio atual conta com 10 itens, entre lanches, bebidas, porções e sobremesas.

---

## Como executar o projeto

### Pré-requisitos
- Flutter instalado (versão compatível)
- Dart SDK configurado
- Emulador ou dispositivo físico

### Passos

Clone o repositório:
```bash
git clone https://github.com/MariaEduardaMonteiro/fast_food_pedido.git
```

Acesse a pasta do projeto:
```bash
cd fast_food_pedido
```

Instale as dependências:
```bash
flutter pub get
```

Execute o projeto:
```bash
flutter run
```