-- Question 1: Achieving 1NF (First Normal Form)
-- Transform ProductDetail table into 1NF by ensuring each row contains only one product per order.
-- Create a new table for 1NF transformation
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Insert data into the new table, separating products into individual rows
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- This query transforms the table into 1NF where each row has a single product per order.


-- Question 2: Achieving 2NF (Second Normal Form)
-- The OrderDetails table is in 1NF but violates 2NF because of partial dependency (CustomerName depends only on OrderID).
-- To achieve 2NF, we will create two tables: one for orders and one for order details.

-- Step 1: Create a table for orders (storing OrderID and CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Step 2: Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Step 3: Create a table for order details (storing OrderID, Product, and Quantity)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Step 4: Insert data into the OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

-- Now, the database is in 2NF. 
-- We have removed the partial dependency by creating two tables: one for orders and one for order details.
