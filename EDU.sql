CREATE DATABASE EDU_PRO;
USE EDU_PRO;


CREATE TABLE Students (
    StudentID VARCHAR(10) PRIMARY KEY,
    StudentName VARCHAR(100),
    DateOfBirth DATE
);


CREATE TABLE Courses (
    CourseID VARCHAR(10) PRIMARY KEY,
    CourseName VARCHAR(100)
);


CREATE TABLE Enrollments (
    StudentID VARCHAR(10),
    CourseID VARCHAR(10),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);


INSERT INTO Students VALUES
('SV001', 'Nguyen Van A', '2000-01-01'),
('SV002', 'Tran Thi B', '2002-05-10'),
('SV003', 'Le Van C', '2001-03-15'),
('SV004', 'Pham Thi D', '2003-07-20'),
('SV005', 'Hoang Van E', '2004-09-25');


INSERT INTO Courses VALUES
('KH001', 'Philosophy'),
('KH002', 'Advanced Mathematics'),
('KH003', 'Communicative English'),
('KH004', 'Database Systems'),
('KH005', 'Java Programming');


INSERT INTO Enrollments VALUES
('SV001', 'KH001', 7.5),
('SV002', 'KH003', 9.0),
('SV003', 'KH003', 9.0),
('SV004', 'KH002', 8.0),
('SV001', 'KH003', 8.5);


-- Sinh viên có độ tuổi trẻ hơn sinh viên có mã "SV001". 
SELECT * 
FROM Students 
WHERE DateOfBirth > (
	SELECT DateOfBirth
    FROM Students
    WHERE StudentID = 'SV001'
);


-- Sinh viên có thông tin (Tên, Mã SV, Điểm) của thủ khoa môn "Tiếng Anh Giao Tiếp"
SELECT s.StudentName AS 'Tên sinh viên', s.StudentID AS 'Mã sinh viên', e.Score AS 'Điểm'
FROM Enrollments e
JOIN Students s ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE e.Score = (
	SELECT MAX(e2.Score)
    FROM Enrollments e2
	JOIN Courses c2 ON e2.CourseID = c2.CourseID
    WHERE c2.CourseName = 'Communicative English'
);


-- Sinh viên chưa đăng ký bất kỳ khóa học nào
SELECT s.StudentName AS 'Tên sinh viên', s.StudentID AS 'Mã sinh viên'
FROM Students s
LEFT JOIN Enrollments e ON e.StudentID = s.StudentID
WHERE e.StudentID IS NULL;

-- XOÁ KHOÁ HỌC "TRIẾT HỌC"
DELETE FROM Enrollments
WHERE CourseID = (
	SELECT CourseID 
    FROM Courses
    WHERE CourseName = 'Philosophy'
);

DELETE FROM Courses
WHERE CourseName = 'Philosophy';