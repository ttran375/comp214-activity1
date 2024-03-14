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
