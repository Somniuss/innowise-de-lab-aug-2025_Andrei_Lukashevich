-- Найдите всех клиентов, которые сделали заказ с максимальной суммой
SELECT c.first_name, c.last_name, o.amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
WHERE o.amount = (SELECT MAX(amount) FROM Orders);