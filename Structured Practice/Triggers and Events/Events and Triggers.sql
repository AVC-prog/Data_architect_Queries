use sql_hr;

-- create a trigger that updates the stock quantity in the inventory table
-- every time sales table gets a new set of values inserted

DELIMITER $$

CREATE TRIGGER UpdateStockAfterSale
AFTER INSERT ON Sales
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET stock_quantity = stock_quantity - NEW.quantity_sold
    WHERE product_id = sales.product_id;
END $$

DELIMITER ;

INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date)
VALUES (2, 1, 5, NOW());

-- Create an event that restocks every day the Laptop stock by adding 5

DELIMITER $$

CREATE EVENT ReplenishStock
ON SCHEDULE EVERY 1 DAY
STARTS '2025-02-28 00:00:00'
DO
BEGIN
    UPDATE Inventory
    SET stock_quantity = stock_quantity + 100
    WHERE stock_quantity < 50;
END $$

DELIMITER ;

UPDATE Inventory
SET stock_quantity = 30
WHERE product_id = 1;

-- Create a trigger for stock validation before sale insertion

CREATE TRIGGER PreventSaleIfStockInsufficient
BEFORE INSERT ON Sales
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Get the current stock for the product
    SELECT stock_quantity INTO current_stock
    FROM Inventory
    WHERE product_id = NEW.product_id;

    -- Check if there is sufficient stock
    IF current_stock < NEW.quantity_sold THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock for the sale';
    END IF;
END $$

DELIMITER ;

INSERT INTO Sales (sale_id, product_id, quantity_sold, sale_date)
VALUES (2, 1, 60, NOW()); 