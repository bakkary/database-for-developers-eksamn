CREATE ROLE ChiefLibrarian;
CREATE ROLE ReferenceLibrarian;
CREATE ROLE CheckOutStaff;
CREATE ROLE LibraryAssistant;
CREATE ROLE DeptLibrarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON Borrow TO ChiefLibrarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON LibUser TO ChiefLibrarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON Membership TO ChiefLibrarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON Resource TO ChiefLibrarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON CopyDetails TO ChiefLibrarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON Contributer TO ChiefLibrarian;
GRANT SELECT, INSERT, UPDATE ON Borrow TO CheckOutStaff;
GRANT SELECT, UPDATE ON CopyDetails TO CheckOutStaff;
GRANT SELECT ON Resource TO CheckOutStaff;
GRANT SELECT ON Membership TO CheckOutStaff;
GRANT SELECT ON Resource TO ReferenceLibrarian;
GRANT SELECT ON Contributer TO ReferenceLibrarian;
GRANT SELECT ON Resource TO LibraryAssistant;
GRANT SELECT ON CopyDetails TO LibraryAssistant;
GRANT SELECT, INSERT, UPDATE, DELETE ON Resource TO DeptLibrarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON Contributer TO DeptLibrarian;
CREATE LOGIN AssistantUser WITH PASSWORD = 'Library123!';
CREATE USER AssistantUser FOR LOGIN AssistantUser;
EXEC sp_addrolemember 'LibraryAssistant', 'AssistantUser';
