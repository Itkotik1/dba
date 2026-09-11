INSERT INTO customers (name, email, phone, region) VALUES
    ('Анна Петрова',   'anna@example.com',  '+7-900-111-22-33', 'MSK'),
    ('Игорь Сидоров',  'igor@example.com',  '+7-900-222-33-44', 'SPB'),
    ('Мария Козлова',  'maria@example.com', '+7-900-333-44-55', 'MSK');

INSERT INTO products (name, price, stock_qty) VALUES
    ('Ноутбук',   89999.00, 15),
    ('Мышь',       1299.00, 200),
    ('Клавиатура', 3499.00, 100);

INSERT INTO orders (customer_id, status, total_amount) VALUES
    (1, 'delivered', 91298.00),
    (2, 'pending',    1299.00),
    (3, 'processing', 3499.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
    (1, 1, 1, 89999.00),
    (1, 2, 1,  1299.00),
    (2, 2, 1,  1299.00),
    (3, 3, 1,  3499.00);