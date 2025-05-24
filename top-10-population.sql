USE GTLibraryDB;
GO

-- Optional: clean up previous test data if IDs already exist
DELETE FROM Borrow WHERE borrowID BETWEEN 7002 AND 7013;
DELETE FROM CopyResource WHERE copyID BETWEEN 8002 AND 8010;
DELETE FROM CopyDetails WHERE copyID BETWEEN 8002 AND 8010;
DELETE FROM Resource WHERE resourceID BETWEEN 9002 AND 9010;
GO

-- Step 1: Insert Resources (Books)
INSERT INTO Resource (resourceID, Title, Description, Type) VALUES
(9002, 'SQL Fundamentals', 'Learn SQL basics', 'Book'),
(9003, 'Data Structures in C', 'Algorithms and data structures', 'Book'),
(9004, 'Modern Databases', 'Theory and practice', 'Book'),
(9005, 'Intro to Python', 'Python for data science', 'Book'),
(9006, 'Operating Systems', 'OS design principles', 'Book'),
(9007, 'Machine Learning', 'Introductory ML concepts', 'Book'),
(9008, 'Cloud Computing', 'Architectures and design', 'Book'),
(9009, 'Computer Networks', 'Protocols and topologies', 'Book'),
(9010, 'Artificial Intelligence', 'AI overview and methods', 'Book');
GO

-- Step 2: Insert CopyDetails
INSERT INTO CopyDetails (copyID, Availability, userID) VALUES
(8002, 1, 1),
(8003, 1, 2),
(8004, 1, 3),
(8005, 1, 1),
(8006, 1, 2),
(8007, 1, 3),
(8008, 1, 1),
(8009, 1, 2),
(8010, 1, 3);
GO

-- Step 3: Link Copies to Resources
INSERT INTO CopyResource (copyID, resourceID) VALUES
(8002, 9002),
(8003, 9003),
(8004, 9004),
(8005, 9005),
(8006, 9006),
(8007, 9007),
(8008, 9008),
(8009, 9009),
(8010, 9010);
GO

-- Step 4: Insert Borrow Records
INSERT INTO Borrow (borrowID, copyID, userID, BorrowDate, DueDate, ReturnDate) VALUES
(7002, 8002, 1, '2025-01-01', '2025-01-15', '2025-01-10'),
(7003, 8002, 2, '2025-02-01', '2025-02-15', '2025-02-14'),
(7004, 8002, 3, '2025-03-01', '2025-03-15', NULL),

(7005, 8003, 2, '2025-04-01', '2025-04-15', '2025-04-13'),
(7006, 8004, 3, '2025-04-05', '2025-04-19', '2025-04-18'),
(7007, 8005, 1, '2025-04-07', '2025-04-21', '2025-04-20'),

(7008, 8006, 2, '2025-04-10', '2025-04-24', NULL),
(7009, 8006, 3, '2025-05-01', '2025-05-15', NULL),

(7010, 8007, 1, '2025-05-01', '2025-05-15', NULL),
(7011, 8008, 1, '2025-04-30', '2025-05-14', NULL),
(7012, 8009, 2, '2025-04-25', '2025-05-09', NULL),
(7013, 8010, 3, '2025-04-20', '2025-05-04', NULL);
GO
