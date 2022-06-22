SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.'; 

CREATE UNIQUE INDEX customers_customername
ON customers (customername);

EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.'; 
