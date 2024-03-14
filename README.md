# Group Lab Ac,vity #1

## Question 1

1. Create a procedure that accepts a category name and retrieves the product and the total
sales for the category.
a. Use an anonymous block to call the procedure and output the result.

## Question 2

2. Create a stored procedure to retrieve the n most expensive products, where n is a number.
Use an anonymous block to call the stored procedure and display the results.
3. Challenge 6-1: Create a func/on to return a descrip/on for the coffee grind. The input
value 3 indicates “Whole Bean,” and the value 4 indicates “Ground.” If a NULL value is
provided as input, the func/on should return N/A.
a. First, test the func/on with an anonymous block.
b. Second, test an SQL statement on the BB_BASKETITEM table, using the OPTION2
column as input.
4. Challenge 6-2: Create a func/on to calculate the total pounds of coffee in an order. Keep
in mind that the OPTION1 column in the BB_BASKETITEM table indicates the purchase of
a half or whole pound. (This column is NULL for equipment items.) Also, you need to
take the quan/ty of each item ordered into account. The input value to the func/on
should be a basket ID.
a. First, test the func/on with basket ID 3, using an anonymous block.
b. Second, test the func/on in an SQL statement, using the BB_BASKET table, that
shows every basket.
