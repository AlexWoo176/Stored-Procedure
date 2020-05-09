create table codegym_customer.newproduct
select productCode, productName, buyPrice, quantityInStock, productDescription
from classicmodels.products;

select *
from newproduct;

alter table newproduct
    add column
        ID            int(5) not null auto_increment,
    add column
        productStatus bit,
    add primary key (ID);

select *
from newproduct;

update newproduct
set productStatus = 1
where ID >= 1;

select *
from newproduct;

drop table products;

alter table newproduct
    rename column quantityInStock to productAmount;

select *
from newproduct;

alter table newproduct
    rename column buyPrice to productPrice;
select *
from newproduct;

create unique index newproduct_index on newproduct (productCode);

create unique index newproduct_index2 on newproduct (productName, productPrice);

EXPLAIN
SELECT *
FROM newproduct
WHERE productCode = 'S12_1108';

EXPLAIN
SELECT *
FROM newproduct
WHERE productPrice > 50.00;

CREATE VIEW newproduct_views AS
SELECT productCode, productName, productPrice, productStatus
FROM newproduct;

UPDATE newproduct_views
SET productName = 'Hello Viet Nam'
WHERE productPrice = 60.62;

SELECT *
FROM newproduct_views;

DELIMITER //
CREATE PROCEDURE findAllProducts()
BEGIN
    SELECT * FROM newproduct;
end//
DELIMITER ;

CALL findAllProducts();

DELIMITER //
CREATE PROCEDURE findProductByID()
BEGIN
    SELECT *
    FROM newproduct
    WHERE newproduct.ID = 5;
end //
DELIMITER ;

CALL findProductByID();

DELIMITER //
DROP PROCEDURE IF EXISTS `findProductByID`//
CREATE PROCEDURE getProductById(IN proID int(5))
BEGIN
    SELECT *
    FROM newproduct
    WHERE newproduct.ID = proID;
end //
DELIMITER ;

CALL getProductById(20);

DELIMITER //
CREATE PROCEDURE getOrderAmount()
BEGIN
    SELECT sum(productPrice * productAmount)
    from newproduct;
end //
DELIMITER ;

CALL getOrderAmount();

DELIMITER //
CREATE PROCEDURE addProduct(code varchar(15),
                            name varchar(70),
                            price decimal(10, 2),
                            amount smallint,
                            description text,
                            status bit)
BEGIN
    insert into newproduct(productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES (code, name, price, amount, description, 1);
end //
DELIMITER ;

Call addProduct('A001', 'Honda Cup', 59.59, 10, 'Het Hang', 1);

DELIMITER //
CREATE PROCEDURE updateProduct(code varchar(15),
                               name varchar(70),
                               price decimal(10, 2),
                               amount smallint,
                               description text,
                               id int,
                               status bit)
begin
    update newproduct
    set productCode        = code,
        productName        = name,
        productPrice       = price,
        productAmount      = amount,
        productDescription = description,
        productStatus      = status
    where ID = id;
end //
DELIMITER ;

call updateProduct();

delimiter //
create procedure delete_record (in ID int)
begin
    delete from newproduct where id = ID;
end //
delimiter ;

call delete_record(111);
select *
from newproduct;


