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

-- 3. Challenge 6-1: Create a function to return a description for the coffee grind. The input
-- value 3 indicates “Whole Bean,” and the value 4 indicates “Ground.” If a NULL value is
-- provided as input, the func/on should return N/A.
-- a. First, test the func/on with an anonymous block.
-- b. Second, test an SQL statement on the BB_BASKETITEM table, using the OPTION2
-- column as input.
CREATE OR REPLACE FUNCTION get_coffee_grind_description(
    p_grind_id IN NUMBER
) RETURN VARCHAR2 IS
    l_description VARCHAR2(50);
BEGIN
    CASE p_grind_id
        WHEN 3 THEN
            l_description := 'Whole Bean';
        WHEN 4 THEN
            l_description := 'Ground';
        ELSE
            l_description := 'N/A';
    END CASE;

    RETURN l_description;
END;
/

DECLARE
    l_grind_id NUMBER := 3; -- Change this value to test different scenarios
    l_result   VARCHAR2(50);
BEGIN
    l_result := get_coffee_grind_description(l_grind_id);
    DBMS_OUTPUT.PUT_LINE('Coffee Grind Description: '
                         || l_result);
END;
/

DECLARE
    l_grind_id NUMBER := 3; -- Change this value to test different scenarios
    l_result   VARCHAR2(50);
BEGIN
    l_result := get_coffee_grind_description(l_grind_id);
    DBMS_OUTPUT.PUT_LINE('Coffee Grind Description: '
                         || l_result);
END;
/

SELECT
    bb_basketitem.option2,
    get_coffee_grind_description(bb_basketitem.option2) AS coffee_grind_description
FROM
    bb_basketitem;

-- 4. Challenge 6-2: Create a func/on to calculate the total pounds of coffee in an order. Keep
-- in mind that the OPTION1 column in the BB_BASKETITEM table indicates the purchase of
-- a half or whole pound. (This column is NULL for equipment items.) Also, you need to
-- take the quan/ty of each item ordered into account. The input value to the func/on
-- should be a basket ID.
-- a. First, test the func/on with basket ID 3, using an anonymous block.
-- b. Second, test the func/on in an SQL statement, using the BB_BASKET table, that
-- shows every basket.
CREATE OR REPLACE FUNCTION calculate_coffee_pounds(
    basket_id IN NUMBER
) RETURN NUMBER IS
    total_pounds NUMBER := 0;
BEGIN
    SELECT
        SUM(
            CASE
                WHEN bi.option1 = 1 THEN
                    p.stock * 0.5
                WHEN bi.option1 = 2 THEN
                    p.stock
                ELSE
                    0
            END * bi.quantity) INTO total_pounds
    FROM
        bb_basketitem bi
        JOIN bb_product p
        ON bi.idProduct = p.idProduct
    WHERE
        bi.idBasket = basket_id
        AND p.Type = 'C';
    RETURN total_pounds;
END;
/

DECLARE
    coffee_pounds NUMBER;
BEGIN
    coffee_pounds := calculate_coffee_pounds(3);
    DBMS_OUTPUT.PUT_LINE('Total pounds of coffee in basket 3: '
                         || coffee_pounds);
END;
/

SELECT
    idBasket,
    calculate_coffee_pounds(idBasket) AS total_coffee_pounds
FROM
    bb_basket;
