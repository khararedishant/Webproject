CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

CREATE TABLE IF NOT EXISTS books (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100) NOT NULL,
    category VARCHAR(80) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Available'
);

INSERT INTO books (title, author, category, status) VALUES
('Java: The Complete Reference', 'Herbert Schildt', 'Programming', 'Available'),
('Head First Java', 'Kathy Sierra', 'Programming', 'Issued'),
('Database System Concepts', 'Silberschatz', 'Database', 'Available'),
('Clean Code', 'Robert C. Martin', 'Programming', 'Available');
