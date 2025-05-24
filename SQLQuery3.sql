USE GTLibraryDB;
GO

CREATE TABLE Borrow (
    borrowID INT IDENTITY(1,1) PRIMARY KEY,
    copyID INT NOT NULL,
    userID INT NOT NULL,
    borrowDate DATE NOT NULL,
    dueDate DATE NOT NULL,
    returnDate DATE NULL,
    FOREIGN KEY (copyID) REFERENCES CopyDetails(copyID),
    FOREIGN KEY (userID) REFERENCES LibUser(userID)
);
