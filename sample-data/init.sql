CREATE TABLE customers (
  id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers (first_name, last_name, email) VALUES ('John', 'Doe', 'john.doe@example.com');
INSERT INTO customers (first_name, last_name, email) VALUES ('Jane', 'Smith', 'jane.smith@example.com');
INSERT INTO customers (first_name, last_name, email) VALUES ('Bob', 'Johnson', 'bob.j@example.com');
INSERT INTO customers (first_name, last_name, email) VALUES ('Alice', 'Williams', 'alice.w@example.com');
