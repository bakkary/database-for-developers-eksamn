INSERT INTO CopyDetails (copyID, Availability, userID)
VALUES (8001, 1, 1);  -- Make sure userID = 1 exists in LibUser
INSERT INTO Resource (resourceID, Title, Description, Type)
VALUES (9001, 'Test Book', 'Sample for testing joins', 'Book');
INSERT INTO CopyResource (copyID, resourceID)
VALUES (8001, 9001);
INSERT INTO Borrow (borrowID, copyID, userID, BorrowDate, DueDate, ReturnDate)
VALUES (7001, 8001, 1, '2025-05-01', '2025-05-10', NULL);
SELECT b.borrowID, b.copyID, cd.copyID, cr.resourceID, r.Title
FROM Borrow b
JOIN CopyDetails cd ON b.copyID = cd.copyID
JOIN CopyResource cr ON cd.copyID = cr.copyID
JOIN Resource r ON cr.resourceID = r.resourceID;
