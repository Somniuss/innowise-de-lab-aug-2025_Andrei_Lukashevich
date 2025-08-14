-- Выведите список доставок со статусом и именем клиента.
SELECT s.status, c.first_name, c.last_name
FROM Shippings s
JOIN Customers c ON s.customer_id = c.customer_id;