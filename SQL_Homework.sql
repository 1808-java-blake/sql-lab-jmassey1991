-- Part I – Working with an existing database
SET SCHEMA 'chinook'; -- FOR THE WHOLE THANG
-- 1.0	Setting up Oracle Chinook
-- In this section you will begin the process of working with the Oracle Chinook database
-- Task – Open the Chinook_Oracle.sql file and execute the scripts within.
-- 2.0 SQL Queries
-- In this section you will be performing various queries against the Oracle Chinook database.
-- 2.1 SELECT
-- Task – Select all records from the Employee table.
SELECT * FROM Employee;
-- Task – Select all records from the Employee table where last name is King.
SELECT * FROM Employee
WHERE lastname = 'King';
-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.
SELECT * FROM Employee
WHERE firstname = 'Andrew'
AND reportsto is NULL;
-- 2.2 ORDER BY
-- Task – Select all albums in Album table and sort result set in descending order by title.
SELECT * FROM Album
ORDER BY title DESC;
-- Task – Select first name from Customer and sort result set in ascending order by city
SELECT firstname 
FROM customer 
ORDER BY city ASC;
-- 2.3 INSERT INTO
-- Task – Insert two new records into Genre table
INSERT INTO Genre (genreid, "name")
VALUES (26, 'Electro Pop'), (27, 'Vapor Soul');
-- Task – Insert two new records into Employee table
INSERT INTO employee 
VALUES (9, 'blob', 'boy', 'Trash N Stuff', 1, '1989-04-22', '2005-09-30', '123 No Where', 'HateCity', 'HelpMe', 'Cambodia', '6969', '903-227-2834', '903-345-3458', 'blobboy@chinookcorp.com'),
(10, 'blob', 'boy', 'Trash N Stuff', 1, '1989-04-22', '2005-09-30', '123 No Where', 'HateCity', 'HelpMe', 'Cambodia', '6969', '903-227-2834', '903-345-3458', 'blobboy@chinookcorp.com');
-- Task – Insert two new records into Customer table
INSERT INTO customer
VALUES (60, 'Hate', 'Fear', 'Plumbus', '321 YesDaddy', 'PlagueCity', 'TX', 'US and A', '34543', '903-234-2345', '456-457-2334', 'grabme@gmail.com', 5),
(61, 'Hate', 'Fear', 'Plumbus', '321 YesDaddy', 'PlagueCity', 'TX', 'US and A', '34543', '903-234-2345', '456-457-2334', 'grabme@gmail.com', 5);
-- 2.4 UPDATE
-- Task – Update Aaron Mitchell in Customer table to Robert Walter
UPDATE customer 
SET firstname = 'Robert', lastname = 'Walter'
WHERE firstname = 'Aaron' AND lastname = 'Mitchell';
-- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”
UPDATE artist
SET "name" = 'CCR'
WHERE "name" = 'Creedence Clearwater Revival';
-- 2.5 LIKE
-- Task – Select all invoices with a billing address like “T%”
SELECT * FROM invoice
WHERE billingaddress LIKE 'T%';
-- 2.6 BETWEEN
-- Task – Select all invoices that have a total between 15 and 50
SELECT * FROM invoice
WHERE total BETWEEN 15 AND 50;
-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004
SELECT * FROM employee
WHERE hiredate BETWEEN '2003-06-01' AND '2004-03-01';
-- 2.7 DELETE
-- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).
DELETE FROM invoiceline 
WHERE invoiceid in (
    SELECT invoiceid FROM invoice WHERE customerid IN (
        SELECT customerid FROM customer WHERE firstname = 'Robert' AND lastname = 'Walter'));
DELETE FROM invoice
WHERE customerid IN (
    SELECT customerid FROM customer WHERE firstname = 'Robert' AND lastname = 'Walter');
DELETE FROM customer 
WHERE firstname = 'Robert' AND lastname = 'Walter';
-- 3.0	SQL Functions
-- In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database
-- 3.1 System Defined Functions
-- Task – Create a function that returns the current time.
CREATE FUNCTION return_current_time () 
RETURNS TIME AS $currenttime$
   DECLARE
      currenttime TIME;
   BEGIN
    SELECT CURRENT_TIME INTO currenttime;
      RETURN currenttime;
   END; 
   $currenttime$ LANGUAGE plpgsql;

   --running it 
   SELECT return_current_time();

-- Task – create a function that returns the length of a mediatype from the mediatype table
CREATE FUNCTION return_media_length(media_name VARCHAR)
RETURNS VARCHAR AS $media_length$
    DECLARE
        media_length VARCHAR;
    BEGIN
    SELECT LENGTH(media_name) INTO media_length;
    RETURN media_length;
    END;
    $media_length$ LANGUAGE plpgsql;

    --running it 
    SELECT return_media_length((SELECT "name" FROM mediatype WHERE mediatypeid = 1));
-- 3.2 System Defined Aggregate Functions
-- Task – Create a function that returns the average total of all invoices
CREATE FUNCTION average_invoice_total()
RETURNS NUMERIC(3, 2) AS $average_total$
    DECLARE
        average_total NUMERIC(3, 2);
    BEGIN
    SELECT AVG(total) FROM invoice INTO average_total;
    RETURN average_total;
    END;
    $average_total$ LANGUAGE plpgsql;
    
    --running it 
    SELECT average_invoice_total();
-- Task – Create a function that returns the most expensive track
CREATE FUNCTION most_expensive_track()
RETURNS VARCHAR AS $most_expensive$
    DECLARE
        most_expensive VARCHAR;
    BEGIN
    SELECT MAX(unitprice) FROM track INTO most_expensive;
    RETURN most_expensive;
    END;
    $most_expensive$ LANGUAGE plpgsql;
    
    --running it 
    SELECT most_expensive_track();
-- 3.3 User Defined Scalar Functions
-- Task – Create a function that returns the average price of invoiceline items in the invoiceline table
-- 3.4 User Defined Table Valued Functions
-- Task – Create a function that returns all employees who are born after 1968.
-- 4.0 Stored Procedures
--  In this section you will be creating and executing stored procedures. You will be creating various types of stored procedures that take input and output parameters.
-- 4.1 Basic Stored Procedure
-- Task – Create a stored procedure that selects the first and last names of all the employees.
-- 4.2 Stored Procedure Input Parameters
-- Task – Create a stored procedure that updates the personal information of an employee.
-- Task – Create a stored procedure that returns the managers of an employee.
-- 4.3 Stored Procedure Output Parameters
-- Task – Create a stored procedure that returns the name and company of a customer.
-- 5.0 Transactions
-- In this section you will be working with transactions. Transactions are usually nested within a stored procedure. You will also be working with handling errors in your SQL.
-- Task – Create a transaction that given a invoiceId will delete that invoice (There may be constraints that rely on this, find out how to resolve them).
-- Task – Create a transaction nested within a stored procedure that inserts a new record in the Customer table
-- 6.0 Triggers
-- In this section you will create various kinds of triggers that work when certain DML statements are executed on a table.
-- 6.1 AFTER/FOR
-- Task - Create an after insert trigger on the employee table fired after a new record is inserted into the table.
-- Task – Create an after update trigger on the album table that fires after a row is inserted in the table
-- Task – Create an after delete trigger on the customer table that fires after a row is deleted from the table.

-- 6.2 INSTEAD OF
-- Task – Create an instead of trigger that restricts the deletion of any invoice that is priced over 50 dollars.
-- 7.0 JOINS
-- In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.
-- 7.1 INNER
-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.
-- 7.2 OUTER
-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.
-- 7.3 RIGHT
-- Task – Create a right join that joins album and artist specifying artist name and title.
-- 7.4 CROSS
-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.
-- 7.5 SELF
-- Task – Perform a self-join on the employee table, joining on the reportsto column.








