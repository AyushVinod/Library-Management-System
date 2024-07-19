CREATE DATABASE LIBRARY;
USE LIBRARY;


CREATE TABLE BRANCH
(
	BRANCH_NO INT PRIMARY KEY,  
	MANAGER_ID INT,
	BRANCH_ADDRESS VARCHAR(20),
	CONTACT_NO BIGINT
);

CREATE TABLE EMPLOYEE
(
	EMP_ID INT PRIMARY KEY,
	EMP_NAME VARCHAR(20),
	POSITION VARCHAR(15),
	SALARY BIGINT,
	BRANCH_NO INT,
    FOREIGN KEY (BRANCH_NO) REFERENCES BRANCH(BRANCH_NO) 
);

CREATE TABLE BOOKS  
(
	ISBN INT PRIMARY KEY,
	BOOK_TITLE VARCHAR(35),  
	CATEGORY VARCHAR(15), 
	RENTAL_PRICE FLOAT,
	STATUS VARCHAR(5), --  [GIVE YES IF BOOK AVAILABLE AND NO IF BOOK NOT AVAILABLE]  
	AUTHOR VARCHAR(25),
	PUBLISHER VARCHAR(25)
);

CREATE TABLE CUSTOMER
(
	CUSTOMER_ID INT PRIMARY KEY,
	CUSTOMER_NAME VARCHAR(20),
	CUSTOMER_ADDRESS VARCHAR(30),
	REG_DATE DATE
);

CREATE TABLE ISSUESTATUS
(
	ISSUE_ID INT PRIMARY KEY,
	ISSUED_CUST INT,-- CUSTOMER_ID IN CUSTOMER TABLE  ISSUED_BOOK_NAME 
	ISSUE_DATE DATE,
	ISBN_BOOK INT,
    FOREIGN KEY (ISSUED_CUST) REFERENCES CUSTOMER(CUSTOMER_ID),
    FOREIGN KEY (ISBN_BOOK) REFERENCES BOOKS(ISBN)
);

CREATE TABLE RETURNSTATUS  
(	RETURN_ID INT PRIMARY KEY,  
	RETURN_CUST VARCHAR(20), 
	RETURN_BOOK_NAME VARCHAR(25),
	RETURN_DATE DATE,
	ISBN_BOOK2 INT,
    FOREIGN KEY (ISBN_BOOK2) REFERENCES BOOKS(ISBN)
);


-- BRANCH INSERTION
INSERT INTO BRANCH (BRANCH_NO, MANAGER_ID, BRANCH_ADDRESS, CONTACT_NO) VALUES 
(1, 101, '123 Main St', 9876543210),
(2, 102, '456 Side St', 8765432109);

-- EMPLOYEE INSERTION
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, POSITION, SALARY, BRANCH_NO) VALUES 
(1, 'Alice Johnson', 'Manager', 75000, 1),
(2, 'Bob Smith', 'Clerk', 40000, 2),
(3, 'Charlie Brown', 'Sales', 50000, 2),
(4, 'Diana Prince', 'HR', 60000, 2),
(5, 'Ethan Hunt', 'Technician', 55000, 1),
(6, 'Fiona Gallagher', 'Receptionist', 35000, 1),
(7, 'George Martin', 'Sales', 52000, 2),
(8, 'Hannah Baker', 'Manager', 72000, 2),
(9, 'Isaac Newton', 'Analyst', 80000, 2),
(10, 'Julia Roberts', 'Clerk', 42000, 1);

-- BOOKS INSERTION
INSERT INTO BOOKS (ISBN, BOOK_TITLE, CATEGORY, RENTAL_PRICE, STATUS, AUTHOR, PUBLISHER) VALUES 
(10, 'Clean Code', 'Programming', 15.99, 'YES', 'Robert C. Martin', 'Prentice Hall'),
(11, 'The Great Gatsby', 'Fiction', 12.50, 'YES', 'F. Scott Fitzgerald', 'Scribner'),
(12, 'Harry Potter Sorcerer\'s Stone', 'Fantasy', 10.00, 'NO', 'J.K. Rowling', 'Scholastic'),
(13, 'The Alchemist', 'Adventure', 14.99, 'YES', 'Paulo Coelho', 'HarperOne'),
(14, '1984', 'History', 13.75, 'YES', 'George Orwell', 'Penguin Books'),
(15, 'To Kill a Mockingbird', 'Fiction', 11.99, 'NO', 'Harper Lee', 'J.B. Lippincott & Co.'),
(16, 'Java Concurrency in Practice', 'Programming', 23.99, 'YES', 'Brian Goetz', 'Addison-Wesley'),
(17, 'Becoming', 'Fantasy', 16.50, 'YES', 'Michelle Obama', 'Crown Publishing'),
(18, 'The Fault in Our Stars', 'Thriller', 10.99, 'NO', 'John Green', 'Dutton Books'),
(19, 'Sapiens: History of Humankind', 'Non-Fiction', 18.99, 'YES', 'Yuval Harari', 'Harvill Secker');

-- CUSTOMER INSERTION
INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_NAME, CUSTOMER_ADDRESS, REG_DATE) VALUES 
(1, 'Alice Smith', '123 Maple Ave', '2015-05-10'),
(2, 'Bob Johnson', '456 Oak St', '2016-07-15'),
(3, 'Charlie Brown', '789 Pine St', '2017-09-20'),
(4, 'Diana Prince', '321 Elm St', '2018-11-25'),
(5, 'Ethan Hunt', '654 Cedar Rd', '2019-03-30'),
(6, 'Fiona Gallagher', '987 Birch Blvd', '2023-06-14'),
(7, 'George Martin', '135 Spruce Ln', '2021-01-19'),
(8, 'Hannah Baker', '246 Walnut Dr', '2022-04-23'),
(9, 'Isaac Newton', '369 Cherry Ct', '2023-06-28'),
(10, 'Julia Roberts', '852 Fir St', '2024-10-05');

-- ISSUE STATUS INSERTION
INSERT INTO ISSUESTATUS(ISSUE_ID ,ISSUED_CUST ,ISSUE_DATE,ISBN_BOOK) VALUES
(111,2,'2023-06-14',12),
(112,3,'2024-01-05',18),
(113,8,'2024-03-01',12),
(114,4,'2019-01-05',13),
(115,5,'2023-06-25',16),
(116,9,'2024-11-12',11);

-- RETURN STATUS INSERTION
INSERT INTO RETURNSTATUS (RETURN_ID, RETURN_CUST, RETURN_BOOK_NAME, RETURN_DATE, ISBN_BOOK2) VALUES
(01, 3, 'The Fault in Our Stars', '2024-07-11', '18'),
(02, 4, 'The Alchemist', '2020-06-15', '13');


-- 01 RETRIEVING THE BOOK TITLE, CATEGORY, AND RENTAL PRICE OF ALL AVAILABLE BOOKS.
SELECT BOOK_TITLE, CATEGORY, RENTAL_PRICE FROM BOOKS WHERE STATUS = 'YES';


-- 02 LISTING THE EMPLOYEE NAMES AND THEIR RESPECTIVE SALARIES IN DESCENDING ORDER OF SALARY.
SELECT EMP_NAME, SALARY FROM EMPLOYEE ORDER BY SALARY DESC;


-- 03 RETRIEVING THE BOOK TITLES AND THE CORRESPONDING CUSTOMERS WHO HAVE ISSUED THOSE BOOKS.
SELECT B.ISBN, B.BOOK_TITLE, C.CUSTOMER_NAME 
FROM BOOKS B, ISSUESTATUS I, CUSTOMER C
WHERE I.ISBN_BOOK = B.ISBN AND I.ISSUED_CUST = C.CUSTOMER_ID;


-- 04 DISPLAYING THE TOTAL COUNT OF BOOKS IN EACH CATEGORY.
SELECT CATEGORY, COUNT(*) AS TOTAL_BOOKS 
FROM BOOKS GROUP BY CATEGORY;


-- 05 RETRIEVING THE EMPLOYEE NAMES AND THEIR POSITIONS FOR THE EMPLOYEES WHOSE SALARIES ARE ABOVE RS.50,000.
SELECT EMP_NAME, POSITION, SALARY
FROM EMPLOYEE WHERE SALARY > 50000;


-- 06 LISTING THE CUSTOMER NAMES WHO REGISTERED BEFORE 2022-01-01 AND HAVE NOT ISSUED ANY BOOKS YET.
SELECT C.CUSTOMER_NAME, C.REG_DATE 
FROM CUSTOMER C LEFT JOIN ISSUESTATUS I
ON C.CUSTOMER_ID = I.ISSUED_CUST WHERE C.REG_DATE<"2022-01-01";


-- 07 DISPLAYING THE BRANCH NUMBERS AND THE TOTAL COUNT OF EMPLOYEES IN EACH BRANCH.
SELECT BRANCH_NO, COUNT(*) AS TOTAL_EMPLOYEES 
FROM EMPLOYEE GROUP BY BRANCH_NO;


-- 08 DISPLAYING THE NAMES OF CUSTOMERS WHO HAVE ISSUED BOOKS IN THE MONTH OF JUNE 2023.
SELECT C.CUSTOMER_NAME,I.ISSUE_DATE 
FROM CUSTOMER C JOIN ISSUESTATUS I
ON I.ISSUED_CUST=C.CUSTOMER_ID 
WHERE I.ISSUE_DATE BETWEEN '2023-06-01' AND '2023-06-30';


-- 09 RETRIEVING BOOK_TITLE FROM BOOK TABLE CONTAINING HISTORY.
SELECT BOOK_TITLE,CATEGORY 
FROM BOOKS WHERE CATEGORY LIKE '%HISTORY%';


-- 10 RETRIEVING THE BRANCH NUMBERS ALONG WITH THE COUNT OF EMPLOYEES FOR BRANCHES HAVING MORE THAN 5 EMPLOYEES
SELECT BRANCH_NO, COUNT(EMP_ID) AS EMPLOYEE_COUNT 
FROM EMPLOYEE GROUP BY BRANCH_NO HAVING COUNT(EMP_ID) > 5;


-- 11 RETRIEVING THE NAMES OF EMPLOYEES WHO MANAGE BRANCHES AND THEIR RESPECTIVE BRANCH ADDRESSES.
SELECT B.BRANCH_NO ,E.EMP_NAME AS MANAGER, B.BRANCH_ADDRESS
FROM EMPLOYEE E JOIN BRANCH B ON E.BRANCH_NO = B.BRANCH_NO 
WHERE E.POSITION = 'MANAGER';


-- 12 DISPLAYING THE NAMES OF CUSTOMERS WHO HAVE ISSUED BOOKS WITH A RENTAL PRICE HIGHER THAN RS. 15.
SELECT C.CUSTOMER_NAME, B.BOOK_TITLE, B.RENTAL_PRICE
FROM ISSUESTATUS I
JOIN BOOKS B ON I.ISBN_BOOK = B.ISBN
JOIN CUSTOMER C ON I.ISSUED_CUST = C.CUSTOMER_ID
WHERE B.RENTAL_PRICE > 15;
