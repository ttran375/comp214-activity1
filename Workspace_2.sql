-- ## Question 3

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
