SELECT id AS payment_id, created_at AS payment_created_at FROM payments WHERE id = (SELECT MAX(id) FROM payments) AND created_at > '2011-09-24';
