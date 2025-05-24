USE GTLibraryDB;
GO

CREATE TABLE LibUser (
    userID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL
);
CREATE TABLE Membership (
    membershipID INT PRIMARY KEY,
    membershipType NVARCHAR(50) NOT NULL CHECK (membershipType IN ('Student', 'Faculty', 'Guest')),
    StartDate DATE NOT NULL,
    ExpirationDate DATE NOT NULL,
    Email NVARCHAR(255) NOT NULL,
    userID INT UNIQUE NOT NULL,
    FOREIGN KEY (userID) REFERENCES LibUser(userID)
);
CREATE TABLE CopyDetails (
    copyID INT PRIMARY KEY,
    Availability BIT NOT NULL, 
    userID INT NULL,
    FOREIGN KEY (userID) REFERENCES LibUser(userID)
);
CREATE TABLE CopyBarcode (
    Barcode NVARCHAR(100) PRIMARY KEY,
    copyID INT NOT NULL UNIQUE,
    FOREIGN KEY (copyID) REFERENCES CopyDetails(copyID)
);
CREATE TABLE Resource (
    resourceID INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    Type NVARCHAR(50) NOT NULL CHECK (Type IN ('Book', 'Article', 'sound-record', 'e-book', 'other'))
);
CREATE TABLE LibraryStaff (
    staffID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Role VARCHAR(50) NOT NULL
);
CREATE TABLE Contributer (
    contributerID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);

-- to make the relations
CREATE TABLE CopyResource (
    copyID INT,
    resourceID INT,
    PRIMARY KEY (copyID, resourceID),
    FOREIGN KEY (copyID) REFERENCES CopyDetails(copyID),
    FOREIGN KEY (resourceID) REFERENCES Resource(resourceID)
);

CREATE TABLE LibraryStaffResource (
    staffID INT,
    resourceID INT,
    PRIMARY KEY (staffID, resourceID),
    FOREIGN KEY (staffID) REFERENCES LibraryStaff(staffID),
    FOREIGN KEY (resourceID) REFERENCES Resource(resourceID)
);
CREATE TABLE ContributerResource (
    contributerID INT,
    resourceID INT,
    PRIMARY KEY (contributerID, resourceID),
    FOREIGN KEY (contributerID) REFERENCES Contributer(contributerID),
    FOREIGN KEY (resourceID) REFERENCES Resource(resourceID)
);
