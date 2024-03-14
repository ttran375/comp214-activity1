CREATE OR REPLACE PROCEDURE GetCategorySales(
    p_category_name IN VARCHAR2
)
IS
    v_total_sales NUMBER := 0;
BEGIN
    -- Retrieve products and their sales for the given category
    FOR product_rec IN (
        SELECT p.ProductID, p.ProductName, od.UnitPrice, od.Quantity, od.Discount
        FROM Products p
        JOIN OrderDetails od ON p.ProductID = od.ProductID
        JOIN Orders o ON od.OrderID = o.OrderID
        JOIN Categories c ON p.CategoryID = c.CategoryID
        WHERE c.CategoryName = p_category_name
    )
    LOOP
        -- Calculate sales for each product
        v_total_sales := v_total_sales + (product_rec.UnitPrice * product_rec.Quantity * (1 - product_rec.Discount));
        
        -- Output product information
        DBMS_OUTPUT.PUT_LINE('Product ID: ' || product_rec.ProductID || ', Product Name: ' || product_rec.ProductName);
    END LOOP;

    -- Output total sales for the category
    DBMS_OUTPUT.PUT_LINE('Total Sales for Category ' || p_category_name || ': ' || v_total_sales);
END;
/
