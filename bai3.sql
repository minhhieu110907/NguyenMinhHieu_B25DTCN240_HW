CREATE DATABASE mini_mart;
USE mini_mart;

-- Categories
CREATE TABLE Categories(
    category_id VARCHAR(5) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Products
CREATE TABLE Products(
    product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id VARCHAR(5),
    price DECIMAL(10,2) NOT NULL,
    stock INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
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

-- Categories
INSERT INTO Categories VALUES
('C01', 'Nước giải khát'),
('C02', 'Thực phẩm'),
('C03', 'Đồ gia dụng');

-- Products
INSERT INTO Products VALUES
('P01', 'Coca Cola lon', 'C01', 10000, 50),
('P02', 'Pepsi lon', 'C01', 12000, 30),
('P03', 'Nước cam', 'C01', 60000, 10),
('P04', 'Bánh mì', 'C02', 15000, 20),
('P05', 'Nồi cơm điện', 'C03', 500000, 5);

-- Customers
INSERT INTO Customers VALUES
('CU01', 'Nguyễn Văn A', 'Hà Nội'),
('CU02', 'Trần Thị B', 'Hồ Chí Minh'),
('CU03', 'Lê Văn C', 'Hà Nội'),
('CU04', 'Phạm Văn D', 'Đà Nẵng');

-- Orders
INSERT INTO Orders VALUES
('O01', 'CU01', '2024-01-01', 'Completed'),
('O02', 'CU02', '2024-01-02', 'Completed'),
('O03', 'CU01', '2024-01-03', 'Pending');

-- Order Details
INSERT INTO Order_Details VALUES
('O01', 'P01', 10, 10000),  -- 100k
('O01', 'P02', 5, 12000),   -- 60k
('O02', 'P05', 1, 500000),  -- 500k
('O02', 'P04', 2, 15000);   -- 30k

-- Tổng doanh thu (chỉ đơn Completed)
SELECT SUM(od.quantity * od.price) AS total_revenue
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
WHERE o.status = 'Completed';


-- Thống kê theo danh mục
SELECT 
    c.category_name AS 'Tên danh mục',
    COUNT(p.product_id) AS 'Số lượng SP',
    AVG(p.price) AS 'Giá trung bình'
FROM Categories c
LEFT JOIN Products p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;


-- Khách hàng chi tiêu > 500.000đ
SELECT 
    c.customer_id,
    c.full_name,
    SUM(od.quantity * od.price) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.full_name
HAVING SUM(od.quantity * od.price) > 500000;


-- Sản phẩm có giá > giá trung bình toàn hệ thống
SELECT *
FROM Products
WHERE price > (
    SELECT AVG(price)
    FROM Products
);