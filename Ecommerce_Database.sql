-- Database for E-commerce 

CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Clients
CREATE TABLE Client (
    idClient INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(45) NOT NULL,
    lastName VARCHAR(90) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    birthDate DATE,
    identification VARCHAR(45) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Products
CREATE TABLE Product (
    idProduct INT PRIMARY KEY AUTO_INCREMENT,
    productName VARCHAR(100) NOT NULL,
    isKids BOOLEAN DEFAULT FALSE,
    category ENUM('Electronics','Clothing','Toys','Food','Furniture') NOT NULL,
    rating DECIMAL(3,1) DEFAULT 0,
    size VARCHAR(20),
    description VARCHAR(255),
    price DECIMAL(10,2) NOT NULL
);

-- Suppliers
CREATE TABLE Supplier (
    idSupplier INT PRIMARY KEY AUTO_INCREMENT,
    corporateName VARCHAR(100) NOT NULL,
    tradeName VARCHAR(100),
    cnpj CHAR(14) NOT NULL UNIQUE
);

-- Third-party sellers
CREATE TABLE ThirdPartySeller (
    idThirdPartySeller INT PRIMARY KEY AUTO_INCREMENT,
    corporateName VARCHAR(100) NOT NULL,
    tradeName VARCHAR(100),
    location VARCHAR(100)
);

-- Stock
CREATE TABLE Stock (
    idStock INT PRIMARY KEY AUTO_INCREMENT,
    location VARCHAR(100)
);

-- Deliveries
CREATE TABLE Delivery (
    idDelivery INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('Processing','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Processing',
    trackingCode VARCHAR(45) NOT NULL UNIQUE,
    shippingDate DATE NOT NULL,
    lastUpdate DATE NOT NULL
);

-- Payments
CREATE TABLE Payment (
    idPayment INT PRIMARY KEY AUTO_INCREMENT,
    idClient INT NOT NULL,
    method ENUM('Card','Pix','Boleto') NOT NULL,
    details VARCHAR(255),
    CONSTRAINT fk_payment_client FOREIGN KEY (idClient) REFERENCES Client(idClient)
);

-- Available products from suppliers
CREATE TABLE AvailableProduct (
    idSupplier INT,
    idProduct INT,
    PRIMARY KEY (idSupplier, idProduct),
    FOREIGN KEY (idSupplier) REFERENCES Supplier(idSupplier),
    FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
);

-- Products sold by third-party sellers
CREATE TABLE ProductsBySeller (
    idThirdPartySeller INT,
    idProduct INT,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idThirdPartySeller, idProduct),
    FOREIGN KEY (idThirdPartySeller) REFERENCES ThirdPartySeller(idThirdPartySeller),
    FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
);

-- Orders
CREATE TABLE Orders (
    idOrder INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM('Processing','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Processing',
    orderDescription VARCHAR(255),
    shippingFee DECIMAL(10,2),
    idClient INT NOT NULL,
    idDelivery INT,
    idPayment INT,
    CONSTRAINT fk_orders_client FOREIGN KEY (idClient) REFERENCES Client(idClient),
    CONSTRAINT fk_orders_delivery FOREIGN KEY (idDelivery) REFERENCES Delivery(idDelivery),
    CONSTRAINT fk_orders_payment FOREIGN KEY (idPayment) REFERENCES Payment(idPayment)
);

-- Products in orders (Order Items)
CREATE TABLE OrderItem (
    idProduct INT,
    idOrder INT,
    quantity INT NOT NULL DEFAULT 1,
    status ENUM('Available','Out of Stock') NOT NULL DEFAULT 'Available',
    PRIMARY KEY (idProduct, idOrder),
    FOREIGN KEY (idProduct) REFERENCES Product(idProduct),
    FOREIGN KEY (idOrder) REFERENCES Orders(idOrder)
);

-- Stock per product 
CREATE TABLE ProductStock (
    idStock INT,
    idProduct INT,
    quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (idStock, idProduct),
    FOREIGN KEY (idStock) REFERENCES Stock(idStock),
    FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
);


