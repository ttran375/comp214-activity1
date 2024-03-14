-- ## Question 1

-- 1. Create a procedure that accepts a category name and retrieves the product and the total
-- sales for the category.
-- a. Use an anonymous block to call the procedure and output the result.
CREATE OR REPLACE PROCEDURE GetCategorySales(
    category_name IN VARCHAR2
) AS
    total_sales NUMBER;
BEGIN
    SELECT
        SUM(od.Quantity * od.UnitPrice * (1 - od.Discount)) INTO total_sales
    FROM
        OrderDetails od
        JOIN Products p
        ON od.ProductID = p.ProductID
        JOIN Categories c
        ON p.CategoryID = c.CategoryID
    WHERE
        c.CategoryName = category_name;
    DBMS_OUTPUT.PUT_LINE('Category: '
                         || category_name);
    DBMS_OUTPUT.PUT_LINE('Total Sales: '
                         || total_sales);
END;
/

DECLARE
    category_name VARCHAR2(15) := 'Beverages';
BEGIN
    GetCategorySales(category_name);
END;
/

CREATE OR REPLACE PROCEDURE GetMostExpensiveProducts(
    n IN NUMBER
) IS
BEGIN
    FOR product IN (
        SELECT
            *
        FROM
            (
                SELECT
                    *
                FROM
                    Products
                ORDER BY
                    UnitPrice DESC
            )
        WHERE
            ROWNUM <= n
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Product ID: '
                             || product.ProductID
                             || ', Product Name: '
                             || product.ProductName
                             || ', Unit Price: '
                             || product.UnitPrice);
    END LOOP;
END;
/

DECLARE
    n NUMBER := 5; -- You can set the value of n as per your requirement
BEGIN
    GetMostExpensiveProducts(n);
END;
/

-- ## Question 2

-- 2. Create a stored procedure to retrieve the n most expensive products, where n is a number.
-- Use an anonymous block to call the stored procedure and display the results.
CREATE OR REPLACE PROCEDURE GetMostExpensiveProducts(
    n IN NUMBER
) IS
BEGIN
    FOR product IN (
        SELECT
            *
        FROM
            (
                SELECT
                    *
                FROM
                    Products
                ORDER BY
                    UnitPrice DESC
            )
        WHERE
            ROWNUM <= n
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Product ID: '
                             || product.ProductID
                             || ', Product Name: '
                             || product.ProductName
                             || ', Unit Price: '
                             || product.UnitPrice);
    END LOOP;
END;
/

DECLARE
    n NUMBER := 5; -- You can set the value of n as per your requirement
BEGIN
    GetMostExpensiveProducts(n);
END;
/
