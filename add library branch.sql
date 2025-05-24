CREATE TABLE LibraryBranch (
    branchID INT PRIMARY KEY,
    Name NVARCHAR(100),
    isCooperating BIT
);

INSERT INTO LibraryBranch (branchID, Name, isCooperating) VALUES
(1, 'Main Campus Library', 1),
(2, 'Partner Tech Library', 1),
(3, 'Old Archive Library', 0);

INSERT INTO LibraryBranch (branchID, Name, isCooperating) VALUES
(1, 'Main Campus Library', 1),
(2, 'Partner Tech Library', 1),
(3, 'Old Archive Library', 0);

UPDATE Resource SET branchID = 1 WHERE resourceID BETWEEN 9002 AND 9010;
UPDATE Membership SET membershipType = 'Student' WHERE userID = 1;
SELECT * FROM CopyDetails WHERE Availability = 1;
UPDATE CopyDetails SET Availability = 1 WHERE copyID = 8002;
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
