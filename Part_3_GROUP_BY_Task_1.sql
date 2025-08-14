-- Подсчитайте количество клиентов в каждой стране
SELECT country, COUNT(*) AS count
FROM Customers
GROUP BY country;