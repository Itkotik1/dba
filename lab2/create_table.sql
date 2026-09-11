-- Покупатели
-- region: в идеале — FK на справочник regions. Для учебного проекта храним текстовый код
-- ('MSK', 'SPB' и т.п.) — это упрощение, которое нарушает 3НФ, но снижает сложность схемы.
-- В production замените на: region_id BIGINT NOT NULL REFERENCES regions(id).
CREATE TABLE customers (
    id         BIGSERIAL PRIMARY KEY,
    name       TEXT NOT NULL,
    email      TEXT NOT NULL UNIQUE,
    phone      TEXT,
    region     TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Товары
CREATE TABLE products (
    id          BIGSERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    description TEXT,
    price       NUMERIC(10,2) NOT NULL CHECK (price > 0),
    stock_qty   INTEGER NOT NULL DEFAULT 0 CHECK (stock_qty >= 0),
    created_at  TIMESTAMPTZ DEFAULT now()
);

-- Заказы
-- total_amount — намеренная денормализация: поле можно вычислить из order_items,
-- но хранится отдельно для быстрого чтения без JOIN (кэшированное значение).
-- Ценой — необходимость синхронизировать значение при каждом изменении позиций.
CREATE TABLE orders (
    id           BIGSERIAL PRIMARY KEY,
    customer_id  BIGINT NOT NULL REFERENCES customers(id),
    status       TEXT NOT NULL DEFAULT 'pending'
                 CHECK (status IN ('pending','processing','shipped','delivered','cancelled')),
    total_amount NUMERIC(12,2) NOT NULL DEFAULT 0,
    created_at   TIMESTAMPTZ DEFAULT now()
);

-- Позиции заказа
CREATE TABLE order_items (
    id         BIGSERIAL PRIMARY KEY,
    order_id   BIGINT NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id BIGINT NOT NULL REFERENCES products(id),
    quantity   INTEGER NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price > 0)
);