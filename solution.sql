-- -- Create a database named bookstore.
CREATE DATABASE bookstore;

-- -- Use the bookstore database.
USE bookstore;

-- Create a table named author.
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    bio TEXT
);

-- Create a table named publisher.
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name  VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255),
    email_address VARCHAR(100),
    phone_number VARCHAR(20)
);

-- Create a table named books.
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author_id INT,
    publisher_id INT,
    genre VARCHAR(100),
    isbn VARCHAR(20) UNIQUE,
    price DECIMAL(10, 2),
    publication_date DATE,
    stock_quantity INT,
    FOREIGN KEY (author_id) REFERENCES author(author_id),
    FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)


);

-- Create a table named book_author.
CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY(book_id,author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id),
    FOREIGN KEY (author_id) REFERENCES author(author_id)
    
);


-- Create a table named book_language.
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(100) NOT NULL UNIQUE
);



-- Customer Table
CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    registration_date DATE NOT NULL DEFAULT (CURRENT_DATE)
);


CREATE TABLE customer_address (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    street VARCHAR(100),
    city VARCHAR(50),
    province VARCHAR(50),
    postal_code VARCHAR(10),
    address_type VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);


CREATE TABLE address_status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);


CREATE TABLE address (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    street VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    province VARCHAR(50),
    postal_code VARCHAR(10),
    country VARCHAR(50)
);



CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL,
    country_code CHAR(2) NOT NULL UNIQUE
);

CREATE TABLE shipping_method (
    shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
    method_name VARCHAR(100) NOT NULL UNIQUE,
    cost DECIMAL(10, 2) NOT NULL,
    estimated_days INT NOT NULL
);


CREATE TABLE order_status (
    order_status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE cust_order (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    shipping_method_id INT NOT NULL,
    order_status_id INT NOT NULL,
    shipping_cost DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);



CREATE TABLE order_line (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    book_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);


CREATE TABLE order_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    order_status_id INT NOT NULL,
    status_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    comments TEXT,
    FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
);


 -- Insert data into order_status table
INSERT INTO order_status (order_status_id, status_name) VALUES 
(1, 'Pending'),
(2, 'Processing'),
(3, 'Shipped');

-- Insert data into shipping_method table
INSERT INTO shipping_method (shipping_method_id, method_name, cost, estimated_days) VALUES 
(1, 'Standard Shipping', 4.99, 5),
(2, 'Express Shipping', 9.99, 2),
(3, 'Overnight Shipping', 19.99, 1);

-- Insert data into cust_order table
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, order_status_id, shipping_cost, total_amount) VALUES
(1, '2023-06-01 10:30:00', 1, 1, 4.99, 29.98),
(2, '2023-06-05 14:15:00', 2, 2, 9.99, 59.98),
(3, '2023-06-10 09:45:00', 3, 3, 0.00, 34.99);


-- Insert data into order_history table
INSERT INTO order_history (order_id, order_status_id, status_date, comments) VALUES
(1, 1, '2023-06-01 10:30:00', 'Order placed'),
(1, 2, '2023-06-01 14:45:00', 'Payment confirmed'),
(1, 3, '2023-06-02 09:30:00', 'Order shipped via USPS');

-- Insert data into order_line table
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 1, 24.99),
(1, 3, 1, 34.99),
(2, 2, 1, 49.99);



-- Inserting data into the book_language table.
INSERT INTO book_language (language_id, language_name)
VALUES (1, 'English'),
       (2, 'Spanish'),
       (3, 'French');



-- Inserting data into the author table.
INSERT INTO author (author_id, first_name, last_name, bio) 
VALUES (1, 'George', 'Orwell', 'English novelist and journalist, best known for 1984 and Animal Farm.'),
       (2, 'Jane', 'Austen', 'English novelist known for works like Pride and Prejudice.'),
       (3, 'J.K.', 'Rowling', 'British author, best known for the Harry Potter series.');

-- Inserting data into the publisher table.
INSERT INTO publisher (publisher_id, full_name, address, email_address, phone_number) 
VALUES (1, 'Penguin Books', '375 Hudson Street, New York, NY', 'info@penguin.com', '072-567-4420'),
       (2,'HarperCollins', '195 Broadway, New York, NY', 'support@harpercollins.com', '987-654-3210');


-- Inserting data into the book table.
INSERT INTO book (book_id, title, author_id, publisher_id, genre, isbn, price, publication_date, stock_quantity)
VALUES (1, '1984', 1, 1, 'Dystopian', '9780451524935', 9.99, '1949-06-08', 100),
       (2, 'Pride and Prejudice', 1, 2, 'Romance', '9780141439518', 7.99, '1813-01-28', 80),
       (3, 'Harry Potter', 2, 1, 'Fantasy', '9780439708180', 10.99, '1997-06-26', 150);

-- Inserting data into the book_author table.
INSERT INTO book_author (book_id, author_id) 
VALUES (1, 1),  -- 1984 by George Orwell
	   (2, 1),  -- Pride and Prejudice by Jane Austen
       (3, 2);  -- Harry Potter by J.K. Rowling


INSERT INTO customer (first_name, last_name, email, phone_number, registration_date) VALUES
('Lerato', 'Mokoena', 'lerato.mokoena@example.com', '0721234567', '2024-03-01'),
('Thabo', 'Dlamini', 'thabo.dlamini@example.com', '0827654321', '2024-04-12'),
('Zanele', 'Ngcobo', 'zanele.ngcobo@example.com', '0739876543', '2024-04-10');


INSERT INTO customer_address (customer_id, street, city, province, postal_code, address_type) VALUES
(1, '101 Nelson Mandela Drive', 'Johannesburg', 'Gauteng', '2000', 'Home'),
(1, '77 Commissioner Street', 'Johannesburg', 'Gauteng', '2001', 'Work'),
(2, '5 Florida Road', 'Durban', 'KwaZulu-Natal', '4001', 'Home'),
(3, '19 Long Street', 'Cape Town', 'Western Cape', '8001', 'Home');


INSERT INTO address_status (status_name) VALUES
('Active'),
('Inactive'),
('Pending Verification');


INSERT INTO address (street, city, province, postal_code, country) VALUES
('101 Nelson Mandela Drive', 'Johannesburg', 'Gauteng', '2000', 'South Africa'),
('77 Commissioner Street', 'Johannesburg', 'Gauteng', '2001', 'South Africa'),
('5 Florida Road', 'Durban', 'KwaZulu-Natal', '4001', 'South Africa'),
('19 Long Street', 'Cape Town', 'Western Cape', '8001', 'South Africa');


INSERT INTO country (country_name, country_code) VALUES
('South Africa', 'ZA'),
('Botswana', 'BW'),
('Namibia', 'NA'),
('Zimbabwe', 'ZW');


-- Users and Permissions
CREATE USER 'bookstore_assistant'@'Localhost' IDENTIFIED BY 'Assist@123';


-- Inventory manager role
CREATE ROLE 'inventory_manager';
GRANT SELECT ON bookstore.* TO 'inventory_manager';
GRANT INSERT, UPDATE, DELETE ON bookstore.book TO 'inventory_manager';
GRANT INSERT, UPDATE, DELETE ON bookstore.book_author TO 'inventory_manager';
GRANT INSERT, UPDATE, DELETE ON bookstore.author TO 'inventory_manager';
GRANT INSERT, UPDATE, DELETE ON bookstore.publisher TO 'inventory_manager';

-- Created a user.
CREATE USER 'kamogelo'@'localhost'
IDENTIFIED BY '12345'; 

-- Created a role.
CREATE ROLE book_admin; 

-- Granting privileges to the role.
GRANT ALL ON bookstore.* TO book_admin;