DROP DATABASE IF EXISTS appdb;
CREATE DATABASE appdb;
USE appdb;

-- =========================
-- USERS
-- =========================
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN','USER') NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL
);

-- =========================
-- MEDICINES
-- =========================
CREATE TABLE medicines (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    price DOUBLE,
    stock INT,
    UNIQUE KEY uniq_medicine_name (name)
);

-- =========================
-- ORDERS
-- =========================
CREATE TABLE orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    total_amount DOUBLE,
    user_id BIGINT,
    status VARCHAR(255) NOT NULL DEFAULT 'PLACED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_date DATETIME,

    CONSTRAINT fk_orders_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE SET NULL
);

-- =========================
-- ORDER ITEMS
-- =========================
CREATE TABLE order_item (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT NOT NULL,
    medicine_id BIGINT NOT NULL,
    quantity INT,
    price DOUBLE,

    CONSTRAINT fk_order_item_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_order_item_medicine
        FOREIGN KEY (medicine_id)
        REFERENCES medicines(id)
);

-- =========================
-- DEFAULT USERS
-- =========================
INSERT INTO users (
    username,
    password,
    role,
    enabled
)
VALUES
(
    'admin',
    '$2a$10$9W8LwSfdRun4tT3ThxmgA.7W82EkJhMrhnls6Tvm6KD6uyB7Gj.8e',
    'ADMIN',
    TRUE
),
(
    'user',
    '$2a$10$X/jrrQdu4Kz9rPK24rPQEeCUi7D1ZY//dvgDuc9qZFvSxLJl65KK.',
    'USER',
    TRUE
);

-- =========================
-- SAMPLE MEDICINES
-- =========================
INSERT INTO medicines (
    name,
    description,
    price,
    stock
)
VALUES
('Paracetamol', 'Fever and pain relief', 20, 100),
('Ibuprofen', 'Anti-inflammatory', 30, 100),
('Amoxicillin', 'Antibiotic', 50, 100),
('Cetirizine', 'Allergy relief', 15, 100),
('Vitamin C', 'Immunity booster', 25, 100),
('Dolo 650', 'Fever reducer', 22, 100),
('Azithromycin', 'Antibiotic', 60, 100);