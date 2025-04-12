-- Create a database named bookstore.
CREATE DATABASE bookstore;

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
    stock_quantity INT
);

-- Create a table named book_author.
CREATE TABLE book_author (
    book_id INT,
    author_id INT
);

-- Create a table named author.
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    bio TEXT
);

-- Create a table named book_language.
CREATE TABLE book_language (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(100) NOT NULL UNIQUE
);

-- Create a table named publisher.
CREATE TABLE publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name  VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255),
    email_address VARCHAR(100),
    phone_number VARCHAR(20)
);


