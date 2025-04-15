# 📚 Bookstore Database

Welcome to the **Bookstore Database** project! This SQL schema models a comprehensive bookstore system including inventory,
customer management, shipping, and orders, complete with roles and permissions.

## 🗃️ Database Name
`bookstore`

## 🧱 Schema Overview

### 📖 `book`
- Details about each book.
- Fields: `title`, `author_id`, `publisher_id`, `genre`, `isbn`, `price`, `publication_date`, `stock_quantity`
- Relationships:
  - 🔗 Foreign Key: `author_id` → `author`
  - 🔗 Foreign Key: `publisher_id` → `publisher`

### ✍️ `author`
- Stores author data with bio and name.

### 🏢 `publisher`
- Publisher contact information and address.

### 📚 `book_author`
- Supports many-to-many relationship between books and authors.

### 🌍 `book_language`
- Languages available for books.

### 👥 `customer`
- Basic customer profile info.

### 🏠 `customer_address`
- Multiple addresses (e.g., Home, Work) per customer.

### 📦 `cust_order`
- All customer orders including shipping and status.

### 🧾 `order_line`
- Each book purchased within an order.

### 📜 `order_history`
- Tracks changes to order statuses over time.

### 📬 `shipping_method`
- Different delivery methods, cost, and timeframes.

### 🧾 `order_status`
- Status of the order: Pending, Processing, Shipped.

### 🌐 `address`, `address_status`, `country`
- Standardized address structure and geography.

## 🔐 Roles & Permissions

### 👤 Users
- `bookstore_assistant`: Limited user for basic access.
- `kamogelo`: General user account.

### 🛡️ Roles
- `inventory_manager`: Can manage books, authors, and publishers.
- `book_admin`: Full access to all tables and data.

### 🧡 Credits
- Mahlatse Mokhabela
- Sindiwe Rana
- Nkululeko Mdubeki
