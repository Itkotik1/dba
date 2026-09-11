-- Профиль «только чтение» — шаблон для аналитиков
CREATE ROLE eshop_readonly NOLOGIN;
GRANT CONNECT ON DATABASE eshop TO eshop_readonly;
GRANT USAGE  ON SCHEMA public TO eshop_readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO eshop_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO eshop_readonly;

-- Профиль «приложение» — для backend-сервиса
CREATE ROLE eshop_app NOLOGIN;
GRANT CONNECT ON DATABASE eshop TO eshop_app;
GRANT USAGE  ON SCHEMA public TO eshop_app;
GRANT SELECT, INSERT, UPDATE ON TABLE orders, order_items TO eshop_app;
GRANT SELECT ON TABLE customers, products TO eshop_app;
GRANT USAGE ON ALL SEQUENCES IN SCHEMA public TO eshop_app;

-- Конкретные пользователи
CREATE ROLE analyst_ivanova LOGIN PASSWORD 'analyst_pass_2024';
GRANT eshop_readonly TO analyst_ivanova;

CREATE ROLE app_backend LOGIN PASSWORD 'backend_pass_2024';
GRANT eshop_app TO app_backend;