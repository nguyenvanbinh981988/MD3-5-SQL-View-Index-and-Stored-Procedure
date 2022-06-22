DELIMITER //

CREATE PROCEDURE FAllCustomers(in customerid int)

BEGIN

  SELECT * FROM customers where customerNumber = customerid;

END //

DELIMITER ;

call FAllCustomers(175);