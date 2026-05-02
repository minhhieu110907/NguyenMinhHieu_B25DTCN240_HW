CREATE DATABASE EDU_PRO;
USE EDU_PRO;

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    InstructorName VARCHAR(100)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    InstructorID INT,
    Fee DECIMAL(10,2),
    Semester VARCHAR(20),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

CREATE TABLE Enrollments (
    StudentID INT,
    CourseID INT,
    Score DECIMAL(4,2),
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

INSERT INTO Instructors VALUES
(1, 'Nguyen Van A'),
(2, 'Tran Thi B'),
(3, 'Le Van C'),
(4, 'Pham Thi D'),
(5, 'Hoang Van E');

INSERT INTO Courses VALUES
(1, 'Basic SQL', 1, 1000000, '2025A'),
(2, 'Python Programming', 2, 1200000, '2025A'),
(3, 'Data Science', 1, 2000000, '2025B'),
(4, 'Machine Learning', 3, 2500000, '2025B'),
(5, 'Web Development', 4, 1500000, '2025A');

INSERT INTO Students VALUES
(1, 'Nguyen An'),
(2, 'Tran Binh'),
(3, 'Le Cuong'),
(4, 'Pham Dung'),
(5, 'Hoang Em');

INSERT INTO Enrollments VALUES
(1, 1, 4.5),
(1, 2, 7.0),
(1, 3, 6.0),
(1, 4, 3.5),
(2, 1, 4.5),
(2, 2, 5.0),
(3, 3, 3.0),
(3, 4, 8.0),
(5, 5, 6.5);

-- ĐẾM SỐ KHOÁ HỌC MỖI GIẢNG VIÊN
SELECT i.InstructorName AS 'Tên giảng viên', COUNT(c.CourseID) AS 'Số khoá học'
FROM Instructors i
JOIN Courses c ON c.InstructorID = i.InstructorID
GROUP BY i.InstructorName;

-- TỔNG DOANH THU MỖI KHOÁ HỌC
SELECT CourseID AS 'MÃ KHOÁ HỌC',SUM(Fee) AS 'DOANH THU'
FROM Courses
GROUP BY CourseID;


-- IN RA TÊN VÀ SỐ LƯỢNG MÔN CỦA SINH VIÊN ĐĂNG KÝ TỪ 3 KHÓA HỌC TRỞ LÊN TRONG CÙNG MỘT KỲ
SELECT s.StudentName AS 'Tên sinh viên', c.Semester AS 'Học kì', COUNT(e.CourseID) AS 'Số lượng môn'
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY s.StudentName, c.Semester
HAVING COUNT(e.CourseID) >= 3;


-- CÁC KHÓA HỌC CÓ ĐIỂM TRUNG BÌNH CỦA SINH VIÊN < 5.0
SELECT c.CourseName AS 'Tên khoá học', ROUND(AVG(e.Score),2) AS 'Điểm trung bình'
FROM Courses c
JOIN Enrollments e 	ON c.CourseID = e.CourseID
GROUP BY c.CourseName
HAVING AVG(e.Score) < 5;