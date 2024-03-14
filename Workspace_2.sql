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
