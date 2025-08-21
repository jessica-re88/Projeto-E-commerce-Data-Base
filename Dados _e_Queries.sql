-- Inserção de Dados e Queries 

use ecommerce;

SHOW TABLES;

INSERT INTO Client (firstName, lastName, cpf, birthDate, identification, address) VALUES
('João', 'Silva', '12345678901', '1990-05-12', 'RG12345', 'Rua das Flores, 100 - São Paulo'),
('Maria', 'Oliveira', '98765432100', '1985-11-30', 'RG67890', 'Av. Brasil, 250 - Rio de Janeiro'),
('Rayssa', 'Veiga', '59445678901', '1990-05-20', 'RG12311', 'Rua de São Miguel, 100 - Bahia'),
('Pedro', 'Maia', '42865432100', '1985-11-11', 'RG67880', 'Rua das Flexeiras, 250 - Ceará'),
('Carlos', 'Pereira', '45678912300', '1995-07-20', 'RG11223', 'Rua Central, 45 - Belo Horizonte');

INSERT INTO Product (productName, isKids, category, rating, size, description, price) VALUES
('iPhone 14', FALSE, 'Electronics', 4.8, NULL, 'Apple smartphone 128GB', 6500.00),
('Camiseta Polo', FALSE, 'Clothing', 4.5, 'M', 'Camiseta polo algodão', 120.00),
('Boneca Barbie', TRUE, 'Toys', 4.7, NULL, 'Boneca Barbie original Mattel', 180.00),
('Sofá Retrátil', FALSE, 'Furniture', 4.2, '3x2m', 'Sofá retrátil confortável', 2500.00),
('Chocolate Nestlé', TRUE, 'Food', 4.9, '100g', 'Chocolate ao leite Nestlé', 7.50);

INSERT INTO Supplier (corporateName, tradeName, cnpj) VALUES
('Tech Distribuidora LTDA', 'Tech Distribuidora', '11111111000111'),
('Fashion Importados SA', 'Fashion SA', '22222222000122'),
('Moveis Prime Ltda', 'Moveis Prime', '33333333000133');

INSERT INTO ThirdPartySeller (corporateName, tradeName, location) VALUES
('Loja do João LTDA', 'Loja do João', 'São Paulo'),
('Kids Brinquedos ME', 'Kids Brinquedos', 'Curitiba'),
('Mega Fashion EIRELI', 'Mega Fashion', 'Rio de Janeiro');

INSERT INTO Stock (location) VALUES
('Centro de Distribuição SP'),
('Centro de Distribuição RJ');

INSERT INTO Delivery (status, trackingCode, shippingDate, lastUpdate) VALUES
('Processing', 'BR123456789', '2025-08-01', '2025-08-02'),
('Shipped', 'BR987654321', '2025-08-05', '2025-08-07'),
('Delivered', 'BR555555555', '2025-07-20', '2025-07-25');

INSERT INTO Payment (idClient, method, details) VALUES
(1, 'Card', 'Visa final 1234'),
(2, 'Pix', 'Chave: maria@email.com'),
(3, 'Boleto', 'Banco do Brasil - Vencimento 25/08/2025');

INSERT INTO AvailableProduct (idSupplier, idProduct) VALUES
(1, 1),  -- iPhone pela Tech Distribuidora
(2, 2),  -- Camiseta pela Fashion SA
(2, 3),  -- Boneca pela Fashion SA
(3, 4),  -- Sofá pela Moveis Prime
(1, 5);  -- Chocolate pela Tech Distribuidora

INSERT INTO ProductsBySeller (idThirdPartySeller, idProduct, quantity) VALUES
(1, 2, 20),  -- João vende camisetas
(2, 3, 15),  -- Kids vende bonecas
(3, 5, 100); -- Mega Fashion vende chocolates

INSERT INTO Orders (status, orderDescription, shippingFee, idClient, idDelivery, idPayment) VALUES
('Processing', 'Pedido de smartphone', 50.00, 1, 1, 1),
('Shipped', 'Pedido de roupas e brinquedos', 30.00, 2, 2, 2),
('Delivered', 'Pedido de sofá', 150.00, 3, 3, 3);

INSERT INTO OrderItem (idProduct, idOrder, quantity, status) VALUES
(1, 1, 1, 'Available'),   
(2, 2, 2, 'Available'),   
(3, 2, 1, 'Available'),  
(4, 3, 1, 'Available');   

INSERT INTO ProductStock (idStock, idProduct, quantity) VALUES
(1, 1, 10),   
(1, 2, 50),   
(2, 3, 30),   
(2, 4, 5),    
(1, 5, 200); 

-- Consultas SQL 

-- Quais são os nomes e preçoes dos produtos cadastrados? 
SELECT productName, price 
FROM Product;

-- Quais são o número de clientes que etenho?
SELECT count(*) FROM client;

-- Quais são os pedidos feitos pelos clientes?
SELECT concat(firstName,' ',c.lastName) as client, o.idOrder, o.status
FROM Client c
JOIN Orders o ON c.idClient = o.idClient;

-- Quais clientes moram em São Paulo?
SELECT firstName, lastName, address
FROM Client
WHERE address LIKE '%São Paulo%';

-- Quais pedidos tem o valor total acima de R$500(considerando também o frete)
SELECT o.idOrder,
       SUM(oi.quantity * p.price) + o.shippingFee AS totalValue
FROM Orders o
JOIN OrderItem oi ON o.idOrder = oi.idOrder
JOIN Product p ON oi.idProduct = p.idProduct
GROUP BY o.idOrder, o.shippingFee
HAVING totalValue > 500;

-- Listar os produtos em ordem dos mais caro para o mais barato
 SELECT productName, price
FROM Product
ORDER BY price DESC;

-- Quais vendedores terceiros têm mais de 5 produtos cadastrados?
SELECT t.tradeName, COUNT(ps.idProduct) AS totalProducts
FROM ThirdPartySeller t
JOIN ProductsBySeller ps ON t.idThirdPartySeller = ps.idThirdPartySeller
GROUP BY t.tradeName
HAVING COUNT(ps.idProduct) > 2;

-- Quais produtos cada cliente comprou, incluindo o nome do cliente, nome do produto, quantidade e valor total de cada item?
SELECT c.firstName, c.lastName, p.productName,
       oi.quantity, (oi.quantity * p.price) AS totalItemValue
FROM Client c
JOIN Orders o ON c.idClient = o.idClient
JOIN OrderItem oi ON o.idOrder = oi.idOrder
JOIN Product p ON oi.idProduct = p.idProduct;

-- Quais pedidos já foram entregues e qual o código de rastreamento da entrega?
SELECT o.idOrder, d.trackingCode, d.status, d.lastUpdate
FROM Orders o
JOIN Delivery d ON o.idDelivery = d.idDelivery
WHERE d.status = 'Delivered';

-- Qual é o preço médio dos produtos cadastrados?
SELECT AVG(price) AS averagePrice
FROM Product;




