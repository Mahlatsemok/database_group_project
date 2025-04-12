-- Create a database named bookstore.
-- CREATE DATABASE bookstore;

-- Use the bookstore database.
USE bookstore;

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

-- -- Create a table named author.
-- CREATE TABLE author (
--     author_id INT PRIMARY KEY AUTO_INCREMENT,
--     first_name VARCHAR(100) NOT NULL,
--     last_name VARCHAR(50) NOT NULL,
--     bio TEXT
-- );

-- -- Create a table named book_language.
-- CREATE TABLE book_language (
--     language_id INT PRIMARY KEY AUTO_INCREMENT,
--     language_name VARCHAR(100) NOT NULL UNIQUE
-- );

-- -- Create a table named publisher.
-- CREATE TABLE publisher (
--     publisher_id INT PRIMARY KEY AUTO_INCREMENT,
--     full_name  VARCHAR(255) NOT NULL UNIQUE,
--     address VARCHAR(255),
--     email_address VARCHAR(100),
--     phone_number VARCHAR(20)
-- );

-- -- Customer Table
-- CREATE TABLE customer (
--     customer_id INT AUTO_INCREMENT PRIMARY KEY,
--     first_name VARCHAR(100) NOT NULL,
--     last_name VARCHAR(100) NOT NULL,
--     email VARCHAR(100) NOT NULL UNIQUE,
--     phone_number VARCHAR(20),
--     registration_date DATE NOT NULL DEFAULT (CURRENT_DATE)
-- );


-- CREATE TABLE customer_address (
--     address_id INT PRIMARY KEY AUTO_INCREMENT,
--     customer_id INT,
--     street VARCHAR(100),
--     city VARCHAR(50),
--     province VARCHAR(50),
--     postal_code VARCHAR(10),
--     address_type VARCHAR(50), -- e.g., 'Home', 'Work', 'Billing'
--     FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
-- );


-- CREATE TABLE address_status (
--     status_id INT AUTO_INCREMENT PRIMARY KEY,
--     status_name VARCHAR(50) NOT NULL
-- );


-- CREATE TABLE address (
--     address_id INT AUTO_INCREMENT PRIMARY KEY,
--     street VARCHAR(100) NOT NULL,
--     city VARCHAR(50) NOT NULL,
--     province VARCHAR(50),
--     postal_code VARCHAR(10),
--     country VARCHAR(50)
-- );



-- CREATE TABLE country (
--     country_id INT AUTO_INCREMENT PRIMARY KEY,
--     country_name VARCHAR(100) NOT NULL,
--     country_code CHAR(2) NOT NULL UNIQUE
-- );

-- CREATE TABLE shipping_method (
--     shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
--     method_name VARCHAR(100) NOT NULL UNIQUE,
--     cost DECIMAL(10, 2) NOT NULL,
--     estimated_days INT NOT NULL
-- );


-- CREATE TABLE order_status (
--     order_status_id INT AUTO_INCREMENT PRIMARY KEY,
--     status_name VARCHAR(50) NOT NULL UNIQUE
-- );

-- CREATE TABLE cust_order (
--     order_id INT AUTO_INCREMENT PRIMARY KEY,
--     customer_id INT NOT NULL,
--     order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     shipping_method_id INT NOT NULL,
--     order_status_id INT NOT NULL,
--     shipping_cost DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
--     total_amount DECIMAL(10, 2) NOT NULL,
--     FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
--     FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
--     FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
-- );



-- CREATE TABLE order_line (
--     order_line_id INT AUTO_INCREMENT PRIMARY KEY,
--     order_id INT NOT NULL,
--     book_id INT NOT NULL,
--     quantity INT NOT NULL,
--     price DECIMAL(10, 2) NOT NULL,
--     FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
--     FOREIGN KEY (book_id) REFERENCES book(book_id)
-- );



-- CREATE TABLE order_history (
--     history_id INT AUTO_INCREMENT PRIMARY KEY,
--     order_id INT NOT NULL,
--     order_status_id INT NOT NULL,
--     status_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     comments TEXT,
--     FOREIGN KEY (order_id) REFERENCES cust_order(order_id) ON DELETE CASCADE,
--     FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
-- );



-- Inventory manager role
CREATE ROLE 'inventory_manager';
GRANT SELECT ON bookstore.* TO 'inventory_manager';
GRANT INSERT, UPDATE, DELETE ON bookstore.book TO 'inventory_manager';
GRANT INSERT, UPDATE, DELETE ON bookstore.book_author TO 'inventory_manager';
GRANT INSERT, UPDATE, DELETE ON bookstore.author TO 'inventory_manager';
GRANT INSERT, UPDATE, DELETE ON bookstore.publisher TO 'inventory_manager';

-- Insert data into country table
INSERT INTO country (country_name, country_code) VALUES 
('South Africa', 'SA'),
('United States', 'US'),
('Canada', 'CA'),
('United Kingdom', 'GB'),
('Germany', 'DE'),
('France', 'FR'),
('Australia', 'AU'),
('Japan', 'JP');

-- Insert data into order_status table
INSERT INTO order_status (status_name) VALUES 
('Pending'),
('Processing'),
('Shipped'),
('Delivered'),
('Cancelled'),
('Returned');

-- Insert data into shipping_method table
INSERT INTO shipping_method (method_name, cost, estimated_days) VALUES 
('Standard Shipping', 4.99, 5),
('Express Shipping', 9.99, 2),
('Overnight Shipping', 19.99, 1),
('Free Shipping', 0.00, 7),
('International Standard', 14.99, 14);

-- Insert sample customer data (assuming customer table already exists)
INSERT INTO customer (first_name, last_name, email, phone, registration_date) VALUES
('John', 'Smith', 'john.smith@email.com', '555-123-4567', '2023-01-15'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-234-5678', '2023-02-20'),
('Michael', 'Brown', 'mbrown@email.com', '555-345-6789', '2023-03-05'),
('Emily', 'Davis', 'emily.davis@email.com', '555-456-7890', '2023-04-10'),
('David', 'Wilson', 'dwilson@email.com', '555-567-8901', '2023-05-22');

-- Insert sample book data (assuming book table already exists)
INSERT INTO book (title, publisher_id, language_id, price, isbn, publication_date, page_count, description) VALUES
('The Great Adventure', 1, 1, 24.99, '978-1234567890', '2022-06-15', 320, 'An epic tale of adventure and discovery'),
('Data Science Fundamentals', 2, 1, 49.99, '978-0987654321', '2023-01-20', 450, 'Comprehensive guide to data science principles'),
('Cooking Essentials', 3, 1, 34.99, '978-5678901234', '2022-09-10', 280, 'Master the basics of cooking with this guide'),
('History of Art', 1, 1, 59.99, '978-6789012345', '2023-03-05', 520, 'A visual journey through art history'),
('Modern Poetry', 4, 1, 19.99, '978-7890123456', '2022-11-30', 180, 'Collection of contemporary poems');

-- Insert data into cust_order table
INSERT INTO cust_order (customer_id, order_date, shipping_method_id, order_status_id, shipping_cost, total_amount) VALUES
(1, '2023-06-01 10:30:00', 1, 4, 4.99, 29.98),
(2, '2023-06-05 14:15:00', 2, 3, 9.99, 59.98),
(3, '2023-06-10 09:45:00', 4, 2, 0.00, 34.99),
(4, '2023-06-15 16:20:00', 3, 1, 19.99, 79.98),
(5, '2023-06-20 11:00:00', 1, 5, 4.99, 24.99),
(2, '2023-06-25 13:30:00', 4, 4, 0.00, 54.98),
(1, '2023-07-01 15:45:00', 2, 3, 9.99, 49.99);

-- Insert data into order_line table
INSERT INTO order_line (order_id, book_id, quantity, price) VALUES
(1, 1, 1, 24.99),
(1, 3, 1, 34.99),
(2, 2, 1, 49.99),
(2, 5, 1, 19.99),
(3, 3, 1, 34.99),
(4, 4, 1, 59.99),
(4, 5, 1, 19.99),
(5, 1, 1, 24.99),
(6, 2, 1, 49.99),
(6, 5, 1, 4.99),
(7, 2, 1, 49.99);

-- Insert data into order_history table
INSERT INTO order_history (order_id, order_status_id, status_date, comments) VALUES
(1, 1, '2023-06-01 10:30:00', 'Order placed'),
(1, 2, '2023-06-01 14:45:00', 'Payment confirmed'),
(1, 3, '2023-06-02 09:30:00', 'Order shipped via USPS'),
(1, 4, '2023-06-05 11:15:00', 'Delivered to customer'),
(2, 1, '2023-06-05 14:15:00', 'Order placed'),
(2, 2, '2023-06-05 16:30:00', 'Payment confirmed'),
(2, 3, '2023-06-06 10:00:00', 'Order shipped via FedEx'),
(3, 1, '2023-06-10 09:45:00', 'Order placed'),
(3, 2, '2023-06-10 13:20:00', 'Order processing'),
(4, 1, '2023-06-15 16:20:00', 'Order placed'),
(5, 1, '2023-06-20 11:00:00', 'Order placed'),
(5, 5, '2023-06-20 15:45:00', 'Order cancelled by customer'),
(6, 1, '2023-06-25 13:30:00', 'Order placed'),
(6, 2, '2023-06-25 15:10:00', 'Payment confirmed'),
(6, 3, '2023-06-26 09:30:00', 'Order shipped via USPS'),
(6, 4, '2023-06-29 14:20:00', 'Delivered to customer'),
(7, 1, '2023-07-01 15:45:00', 'Order placed'),
(7, 2, '2023-07-01 17:30:00', 'Payment confirmed'),
(7, 3, '2023-07-02 10:15:00', 'Order shipped via UPS');

-- QUERY EXAMPLES

-- Created a user.
CREATE USER 'kamogelo'@'localhost'
IDENTIFIED BY '12345'; 

-- Created a role.
CREATE ROLE book_admin; 

-- Granting privileges to the role.
GRANT ALL ON bookstore.* TO book_admin;

-- Inserting data into the book table.
INSERT INTO book (book_id, title, author_id, publisher_id, genre, isbn, price, publication_date, stock_quantity)
VALUES (1, '1984', 1, 1, 'Dystopian', '9780451524935', 9.99, '1949-06-08', 100),
       (2, 'Pride and Prejudice', 1, 2, 'Romance', '9780141439518', 7.99, '1813-01-28', 80),
       (3, 'Harry Potter', 2, 1, 'Fantasy', '9780439708180', 10.99, '1997-06-26', 150);

-- Inserting data into the author table.
INSERT INTO author (author_id, first_name, last_name, bio) 
VALUES (1, 'George', 'Orwell', 'English novelist and journalist, best known for 1984 and Animal Farm.'),
       (2, 'Jane', 'Austen', 'English novelist known for works like Pride and Prejudice.'),
       (3, 'J.K.', 'Rowling', 'British author, best known for the Harry Potter series.');

-- Inserting data into the book_author table.
INSERT INTO book_author (book_id, author_id) 
VALUES (1, 1),  -- 1984 by George Orwell
	   (2, 1),  -- Pride and Prejudice by Jane Austen
       (3, 2);  -- Harry Potter by J.K. Rowling

-- Inserting data into the book_language table.
INSERT INTO book_language (language_id, language_name)
VALUES (1, 'English'),
       (2, 'Spanish'),
       (3, 'French');

-- Inserting data into the publisher table.
INSERT INTO publisher (publisher_id, full_name, address, email_address, phone_number) 
VALUES (1, 'Penguin Books', '375 Hudson Street, New York, NY', 'info@penguin.com', '072-567-4420'),
       (2'HarperCollins', '195 Broadway, New York, NY', 'support@harpercollins.com', '987-654-3210');


-- +++++++++++++++++++++++++++++ Sindiwe +++++++++++++++++++++++++++++++


INSERT INTO customer (customer_id, full_name, email, phone_number, registration_date)
VALUES
(1, 'Alice Mokoena', 'alicemokoena@gmail.com', '0723456789', '2025-01-01'),
(2, 'Bongani Dlamini', 'bonganid@gmail.com', '0739876543', '2023-05-10'),
(3, 'Carla van der Merwe', 'carlavdm@gmail.com', '0741122334', '2025-02-15'),
(4, 'David Ndlovu', 'davidndlovu@gmail.com', '0765566778', '2023-07-22'),
(5, 'Emily Smith', 'emilysmith@gmail.com', '0719988776', '2025-03-30');


INSERT INTO customer_address (customer_id, street, city, province, postal_code, address_type)
VALUES
-- Alice Mokoena
('123 Main St', 'Cape Town', 'Western Cape', '8001', 'Home'),
('456 Market Rd', 'Cape Town', 'Western Cape', '8002', 'Work'),

-- Bongani Dlamini
('789 Sunset Blvd', 'Durban', 'KwaZulu-Natal', '4001', 'Home'),

-- Carla van der Merwe
('488 Mavwel Rd', 'Cape Town', 'Western Cape', '8002', 'Home'),
('401 Market Rd', 'Cape Town', 'Western Cape', '8002', 'Work'),

-- David Ndlovu
('3893 Kgoro Sec', 'Mafikeng', 'North West', '3893', 'Home'),

-- Emily Smith
('10013 Kgomola Sec', 'Lichtenburg', 'North West', '3893', 'Home');


INSERT INTO address_status (status_name,customer)
VALUES
('Active', 'Bongani Dlamini'),
('Active', 'David Ndlovu');


INSERT INTO address (street, city, province, postal_code, country)
VALUES 
('123 Main Street', 'Cape Town', 'Western Cape', '8001', 'South Africa'),
('789 Sunset Blvd', 'Durban', 'KwaZulu-Natal', '4001', 'South Africa'),
('488 Street', 'Cape Town', 'Western Cape', '8002', 'South Africa'),
('3893 Kgoro Sec', 'Lichtenburg', 'North West', '2740', 'South Africa');

INSERT INTO country (coutry_id,country_name)
VALUES 
('+27', 'South Africa');

-- Users and Permissions
CREATE USER 'bookstore_assistant'@'Localhost' IDENTIFIED BY 'Assist@123';


