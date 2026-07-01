# fast_food_pedido

O projeto é um aplicativo mobile desenvolvido em Flutter para a visualização de cardápios e realização de pedidos de fast-food de forma rápida e intuitiva. 

Este projeto foi construído como parte de um teste técnico de processo seletivo, aplicando conceitos de gerenciamento de estado local, navegação padronizada por rotas e boas práticas de arquitetura.

## Funcionalidades

- **Cardápio Dinâmico:** Listagem de produtos consumidos localmente a partir de um arquivo JSON (`assets/data/products.json`).
- **Formulário de Pedido:** Validação inteligente em tempo real (o botão "Finalizar Pedido" só é habilitado após o preenchimento correto do Nome e de um Telefone válido com 10 dígitos numéricos).
- **Tratamento de Dados de Entrada:** Bloqueio nativo de caracteres não numéricos no campo de telefone através de formatadores de texto.
- **Resumo do Pedido:** Exibição clara e organizada com os dados do cliente e detalhes do produto selecionado.
- **Resiliência e Segurança:** Tratamento de erros (`try-catch`) no serviço de carregamento para evitar travamentos caso o arquivo de dados esteja corrompido.

## Tecnologias e Conceitos

- **Flutter & Dart**
- **Navegação Declarativa:** Centralização e padronização através de Rotas Nomeadas (`onGenerateRoute`).
- **Gerenciamento de Estado:** Ciclo de vida controlado com `StatefulWidget`, liberação de recursos (`dispose`) de controladores para evitar *memory leaks*.

---

## Estrutura do Projeto

```text
lib/
├── models/
│   └── product.dart          # Modelo de dados do Produto e Parsing do JSON
├── screens/
│   ├── home_screen.dart      # Tela principal com a listagem do cardápio
│   ├── order_screen.dart     # Tela do formulário de pedido com validação ativa
│   └── summary_screen.dart   # Tela de fechamento e resumo do pedido
├── services/
│   └── product_service.dart  # Serviço responsável pelo consumo resiliente do JSON
├── widgets/
│   └── product_card.dart     # Componente visual do cardápio
└── main.dart                 # Configurações globais de rotas, tema e inicialização