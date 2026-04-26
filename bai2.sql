CREATE DATABASE mini_mart;
USE mini_mart;


-- Brands
CREATE TABLE Brands(
    brand_id VARCHAR(5) PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL UNIQUE
);

-- Products
CREATE TABLE Products(
    product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    brand_id VARCHAR(5),
    price DECIMAL(10,2) NOT NULL,
    stock INT,
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id)
);

-- Customers
CREATE TABLE Customers(
    customer_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(100),
    address VARCHAR(255)
);

-- Orders
CREATE TABLE Orders(
    order_id VARCHAR(5) PRIMARY KEY,
    customer_id VARCHAR(5),
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Order Details
CREATE TABLE Order_Details(
    order_id VARCHAR(5),
    product_id VARCHAR(5),
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


-- Brands
INSERT INTO Brands VALUES
('B01', 'Coca-Cola'),
('B02', 'Pepsi'),
('B03', 'Vinamilk'),
('B04', 'Không sản phẩm');

-- Products
INSERT INTO Products VALUES
('P01', 'Coca Cola lon', 'B01', 10000, 50),
('P02', 'Pepsi lon', 'B02', 12000, 30),
('P03', 'Sữa tươi Vinamilk', 'B03', 30000, 20),
('P04', 'Coca Cola chai', 'B01', 15000, 0);

-- Customers
INSERT INTO Customers VALUES
('C01', 'Nguyễn Văn A', 'Hà Nội'),
('C02', 'Trần Thị B', 'Hồ Chí Minh'),
('C03', 'Lê Văn C', 'Hà Nội'),
('C04', 'Phạm Văn D', 'Đà Nẵng');

-- Orders
INSERT INTO Orders VALUES
('O01', 'C01', '2024-01-01', 'Completed'),
('O02', 'C02', '2024-01-02', 'Pending');

-- Order Details
INSERT INTO Order_Details VALUES
('O01', 'P01', 2, 10000),
('O01', 'P03', 1, 30000),
('O02', 'P02', 3, 12000);


SELECT p.product_id, p.product_name, p.price, p.stock
FROM Products p
JOIN Categories c 
    ON p.category_id = c.category_id
WHERE c.category_name = 'Nước giải khát'
  AND p.price BETWEEN 10000 AND 50000
  AND p.stock > 0;
    
    
SELECT *
FROM Customers
WHERE full_name LIKE 'Nguyễn%' OR address LIKE '%Hà Nội%';


SELECT 
    o.order_id AS 'Mã đơn', o.order_date AS 'Ngày mua', o.status AS 'Trạng thái', c.full_name AS 'Tên khách hàng'
FROM Orders o
JOIN Customers c 
    ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

SELECT 
    c.full_name AS 'Tên khách hàng', o.order_date AS 'Ngày mua', p.product_name AS 'Tên sản phẩm', od.quantity AS 'Số lượng', od.price AS 'Đơn giá'
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;
    
    
SELECT c.*
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
