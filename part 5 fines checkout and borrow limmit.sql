-- query 1
CREATE PROCEDURE CheckoutResource
    @userID INT,
    @copyID INT
AS
BEGIN
    -- Start transaction to ensure atomicity
    BEGIN TRANSACTION;

    -- Check if copy is available
    IF EXISTS (
        SELECT 1 FROM CopyDetails WHERE copyID = @copyID AND Availability = 1
    )
    BEGIN
        -- Insert new borrow record
        INSERT INTO Borrow (copyID, userID, BorrowDate, DueDate, ReturnDate)
        VALUES (
            @copyID,
            @userID,
            GETDATE(),
            DATEADD(DAY, 14, GETDATE()),  -- 2-week due date
            NULL
        );

        -- Set copy as unavailable
        UPDATE CopyDetails
        SET Availability = 0
        WHERE copyID = @copyID;

        COMMIT TRANSACTION;
        PRINT 'Resource checked out successfully.';
    END
    ELSE
    BEGIN
        ROLLBACK TRANSACTION;
        PRINT 'Error: Copy is not available for checkout.';
    END
END;

--run this last part seperatly
EXEC CheckoutResource @userID = 1, @copyID = 8002;
UPDATE Borrow
SET ReturnDate = GETDATE()
WHERE copyID = 8002 AND ReturnDate IS NULL;
UPDATE CopyDetails
SET Availability = 1
WHERE copyID = 8002;

-- query 3
CREATE TRIGGER TR_BorrowLimit
ON Borrow
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @userID INT, @activeBorrows INT, @membershipType NVARCHAR(50), @limit INT;

    SELECT TOP 1 @userID = userID FROM inserted;


    SELECT @membershipType = membershipType
    FROM Membership
    WHERE userID = @userID;

    SET @limit = 
        CASE @membershipType
            WHEN 'Student' THEN 5
            WHEN 'Faculty' THEN 10
            WHEN 'Guest' THEN 2
            ELSE 0
        END;

    SELECT @activeBorrows = COUNT(*)
    FROM Borrow
    WHERE userID = @userID AND ReturnDate IS NULL;

    IF @activeBorrows >= @limit
    BEGIN
        RAISERROR('Borrowing limit exceeded for your membership type.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        INSERT INTO Borrow (borrowID, copyID, userID, BorrowDate, DueDate, ReturnDate)
        SELECT borrowID, copyID, userID, BorrowDate, DueDate, ReturnDate FROM inserted;
    END
END;
--run this last part seperatly
UPDATE Membership SET membershipType = 'Guest' WHERE userID = 1;
-- No return date = still borrowed
UPDATE Borrow SET ReturnDate = NULL WHERE userID = 1;
EXEC CheckoutResource @userID = 1, @copyID = 8003;


CREATE FUNCTION CalculateOverdueFine (@borrowID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @dueDate DATE, @returnDate DATE, @resourceType NVARCHAR(50);
    DECLARE @daysOverdue INT;
    DECLARE @rate DECIMAL(5,2);
    DECLARE @fine DECIMAL(10,2);

    -- Get due date, return date, and type
    SELECT 
        @dueDate = b.DueDate,
        @returnDate = ISNULL(b.ReturnDate, GETDATE()),
        @resourceType = r.Type
    FROM Borrow b
    JOIN CopyResource cr ON b.copyID = cr.copyID
    JOIN Resource r ON cr.resourceID = r.resourceID
    WHERE b.borrowID = @borrowID;

    -- Calculate days overdue
    SET @daysOverdue = DATEDIFF(DAY, @dueDate, @returnDate);
    IF @daysOverdue < 0 SET @daysOverdue = 5;

    -- Determine fine rate
    SET @rate = 
        CASE @resourceType
            WHEN 'Book' THEN 1.0
            WHEN 'Video' THEN 2.0
            WHEN 'sound-record' THEN 1.5
            WHEN 'e-book' THEN 0.5
            ELSE 1.0
        END;

    SET @fine = @daysOverdue * @rate;
    RETURN @fine;
END;
--run this last part seperatly
SELECT dbo.CalculateOverdueFine(7002) AS FineAmount;
