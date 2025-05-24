-- sql 1
SELECT 
    b.borrowID,
    r.Title,
    r.Type,
    b.BorrowDate,
    b.DueDate,
    b.ReturnDate
FROM 
    Borrow b
JOIN 
    CopyDetails cd ON b.copyID = cd.copyID
JOIN 
    CopyResource cr ON cd.copyID = cr.copyID
JOIN 
    Resource r ON cr.resourceID = r.resourceID
WHERE 
    b.userID = 1
    AND b.ReturnDate IS NULL
    AND b.DueDate < GETDATE();

-- sql 2
SELECT TOP 10
    r.Title,
    COUNT(*) AS borrowCount
FROM Borrow b
JOIN CopyResource cr ON b.copyID = cr.copyID
JOIN Resource r ON cr.resourceID = r.resourceID
WHERE r.Type = 'Book'
  AND b.BorrowDate >= DATEADD(YEAR, -1, GETDATE())
GROUP BY r.Title
ORDER BY borrowCount DESC;

-- sql 3
WITH BorrowCounts AS (
    SELECT 
        b.userID,
        COUNT(*) AS borrowCount
    FROM Borrow b
    JOIN CopyResource cr ON b.copyID = cr.copyID
    JOIN Resource r ON cr.resourceID = r.resourceID
    WHERE r.Type = 'Book'
    GROUP BY b.userID
),
AverageBorrow AS (
    SELECT ROUND(AVG(borrowCount * 1.0), 0) AS avgBorrow FROM BorrowCounts
)
SELECT 
    bc.userID,
    lu.Name,
    bc.borrowCount,
    ab.avgBorrow
FROM BorrowCounts bc
JOIN AverageBorrow ab ON 1 = 1
JOIN LibUser lu ON bc.userID = lu.userID
WHERE bc.borrowCount > ab.avgBorrow;

-- query 4
SELECT DISTINCT
    r.resourceID,
    r.Title,
    r.Type,
    lb.Name AS LibraryName
FROM Resource r
JOIN LibraryBranch lb ON r.branchID = lb.branchID
JOIN CopyResource cr ON r.resourceID = cr.resourceID
JOIN CopyDetails cd ON cr.copyID = cd.copyID
JOIN Membership m ON m.userID = cd.userID
WHERE lb.isCooperating = 1
  AND cd.Availability = 1
  AND m.membershipType = 'Student';

  -- query 5
 SELECT 
    c.contributerID,
    c.Name AS ContributorName,
    r.Title
FROM Contributer c
JOIN ContributerResource cr ON c.contributerID = cr.contributerID
JOIN Resource r ON cr.resourceID = r.resourceID
WHERE c.contributerID IN (
    SELECT contributerID
    FROM ContributerResource
    GROUP BY contributerID
    HAVING COUNT(DISTINCT resourceID) > 1
)
ORDER BY c.contributerID, r.Title;
