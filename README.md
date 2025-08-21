# Projeto-E-commerce-Data-Base

Projeto Lógico de Banco de Dados para E-commerce

##  Contexto do Projeto

Este projeto tem como objetivo a modelagem lógica de um banco de dados para um sistema de E-commerce.
A ideia é representar as principais entidades e relacionamentos que existem em um comércio eletrônico, permitindo:

- Cadastro de clientes e seus pedidos.

- Controle de produtos, fornecedores e vendedores terceiros.

- Gestão de estoque e entregas.

- Registro de pagamentos associados às compras.

O modelo lógico foi implementado em MySQL, utilizando boas práticas de normalização, integridade referencial e consistência de nomes.

##  Estrutura do Esquema Lógico

O esquema foi dividido em entidades principais, com relacionamentos adequados para refletir a dinâmica de um e-commerce.

🔹 Principais Entidades

- Client → representa os clientes cadastrados na plataforma.

- Product → armazena informações de produtos, incluindo categoria, preço e se é destinado a crianças.

- Supplier → fornecedores que disponibilizam produtos para a loja.

- ThirdPartySeller → vendedores terceirizados que podem oferecer produtos dentro da plataforma.

- Stock → locais de armazenamento de produtos.

- Delivery → controle de entregas, com status e código de rastreamento.

- Payment → métodos de pagamento utilizados pelos clientes.

- Orders → pedidos realizados pelos clientes.

- OrderItem → itens que compõem cada pedido.

- ProductStock → controle de quantidade de produtos em cada estoque.

- AvailableProduct → produtos fornecidos por cada fornecedor.

- ProductsBySeller → produtos disponibilizados por vendedores terceiros.

##  Relacionamentos

Um cliente pode realizar vários pedidos.

Um pedido está associado a pagamento e a uma entrega.

Cada pedido possui vários itens (OrderItem), relacionados a produtos.

Produtos podem ser vendidos diretamente ou por vendedores terceiros.

Fornecedores disponibilizam produtos à plataforma (AvailableProduct).

O estoque controla a quantidade disponível de cada produto (ProductStock).

##  Regras de Negócio Implementadas

CPF e CNPJ são únicos.

Produtos têm categorias pré-definidas por meio de ENUM.

Pedidos e entregas possuem status controlados (Processing, Shipped, Delivered, Cancelled).

Preços e valores monetários utilizam DECIMAL(10,2) para garantir precisão.

Chaves estrangeiras garantem integridade referencial entre clientes, pedidos, produtos e pagamentos.

##  Exemplos de Consultas Possíveis

Com esse esquema, é possível responder perguntas como:

- Quais são os pedidos feitos por cada cliente?

- Quais produtos foram comprados em determinado pedido?

- Qual o valor total gasto por cada cliente?

- Quais fornecedores oferecem determinado produto?

- Quantos produtos cada vendedor terceirizado possui à venda?

- Qual é o status atual das entregas de pedidos?

##  Conclusão

O modelo lógico desenvolvido reflete as principais necessidades de um sistema de e-commerce e pode ser usado como base para:

Treinamento e ensino de SQL.

Protótipos de sistemas de e-commerce.

Projetos acadêmicos de modelagem de banco de dados.

Ele foi pensado para garantir integridade, escalabilidade e clareza, servindo como um ponto de partida sólido para futuras expansões.
