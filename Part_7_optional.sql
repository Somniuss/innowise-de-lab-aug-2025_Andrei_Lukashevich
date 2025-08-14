-- Найдите клиентов, которые сделали хотя бы 2 заказа и имеют хотя бы одну доставку со статусом 'Delivered'
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    c.country,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Shippings s ON c.customer_id = s.customer_id
WHERE s.status = 'Delivered'
GROUP BY c.customer_id, c.first_name, c.last_name, c.country
HAVING COUNT(o.order_id) >= 2;