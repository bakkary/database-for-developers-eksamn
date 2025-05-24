USE GTLibraryDB;
GO

INSERT INTO LibUser (userID, Name, Email)
VALUES 
(1, 'Alice Johnson', 'alice.johnson@example.com'),
(2, 'Bob Smith', 'bob.smith@example.com'),
(3, 'Carla Reyes', 'carla.reyes@example.com');
INSERT INTO Membership (membershipID, membershipType, StartDate, ExpirationDate, Email, userID)
VALUES 
(101, 'Student', '2024-01-15', '2025-01-15', 'alice.johnson@example.com', 1),
(102, 'Faculty', '2023-08-01', '2024-08-01', 'bob.smith@example.com', 2),
(103, 'Guest', '2025-01-01', '2026-01-01', 'carla.reyes@example.com', 3);
INSERT INTO LibraryStaff (staffID, Name, Role)
VALUES 
(1, 'Daniel Green', 'Archivist'),
(2, 'Eva Wang', 'Technician');
INSERT INTO Contributer (contributerID, Name)
VALUES 
(1, 'Martin Keller'),
(2, 'Nina Akhtar');
INSERT INTO Resource (resourceID, Title, Description, Type)
VALUES 
(1001, 'Intro to Databases', 'An introduction to relational databases', 'Book'),
(1002, 'Advanced SQL Techniques', 'Covers optimization and advanced queries', 'e-book'),
(1003, 'Digital Preservation', 'Seminar recording', 'sound-record');
INSERT INTO CopyDetails (copyID, Availability, userID)
VALUES 
(201, 1, NULL),
(202, 0, 1),
(203, 1, NULL);
INSERT INTO CopyBarcode (Barcode, copyID)
VALUES 
('BC123456', 201),
('BC654321', 202),
('BC987654', 203);
INSERT INTO CopyResource (copyID, resourceID)
VALUES 
(201, 1001),
(202, 1002),
(203, 1003);
INSERT INTO LibraryStaffResource (staffID, resourceID)
VALUES 
(1, 1001),
(2, 1003);
INSERT INTO ContributerResource (contributerID, resourceID)
VALUES 
(1, 1001),
(2, 1002),
(2, 1003);

INSERT INTO CopyDetails (copyID, Availability, userID) VALUES
(101, 1, 1),
(102, 1, 2),
(103, 1, 3);