-- 1. Поиск дубликатов транзакций в таблице платежей (проверка на race condition при отправке API запросов)
SELECT order_id, COUNT(payment_id) as payment_attempts
FROM payments
WHERE status = 'success'
GROUP BY order_id
HAVING COUNT(payment_id) > 1;

-- 2. Сверка статусов заказов между ERP и витриной с использованием JOIN
SELECT o.id AS web_order_id, o.status AS web_status, e.status AS erp_status
FROM web_orders o
LEFT JOIN erp_orders e ON o.external_id = e.id
WHERE o.status != e.status;
