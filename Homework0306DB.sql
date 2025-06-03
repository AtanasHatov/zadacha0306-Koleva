CREATE DATABASE [FUNCTION_DATA]

CREATE TABLE [Students](
[StudentId] INT PRIMARY KEY,
[FirstaName] NVARCHAR (MAX),
[LastName] NVARCHAR (MAX)
)
CREATE TABLE [Subjects](
[SubjectId] INT PRIMARY KEY,
[SubjectName] NVARCHAR (MAX)
)
CREATE TABLE [Exams](
[ExamId] INT PRIMARY KEY,
[StudentId] INT FOREIGN KEY REFERENCES Students(StudentId),
[SubjectId] INT FOREIGN KEY REFERENCES Subjects(SubjectId),
[ExamDate] DATE,
[Grade] DECIMAL (4,2)
)

INSERT INTO Students(StudentId, FirstaName, LastName) 
VALUES
(1, N'Анна', N'Георгиева'),
(2, N'Иван', N'Петров'),
(3, N'Мила', N'Иванова')

INSERT INTO Subjects(SubjectId, SubjectName)
VALUES
(1, N'Бази от данни'),
(2, N'АСД'),
(3, N'Математика')

INSERT INTO Exams (ExamId, StudentId, SubjectId, ExamDate, Grade)
VALUES
(101, 1, 1, '2025-01-15', 5.50),
(102, 1, 2, '2025-02-20', 5.00),
(103, 2, 1, '2025-03-01', 4.10),
(104, 3, 1, '2025-03-10', 5.80),
(105, 3, 3, '2025-04-01', 6.00),
(106, 2, 1, '2025-03-11', 5.90)


CREATE FUNCTION dbo.StudentsGrade
(
    @SubjectName NVARCHAR(MAX),
    @AfterDate DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        s.StudentId,
        s.FirstaName,
        s.LastName,
        subj.SubjectName,
        e.ExamDate,
        e.Grade
    FROM Exams e
    JOIN Students s ON e.StudentId = s.StudentId
    JOIN Subjects subj ON e.SubjectId = subj.SubjectId
    WHERE subj.SubjectName = @SubjectName
      AND e.ExamDate > @AfterDate
)

SELECT * FROM dbo.StudentsGrade(N'Математика', '2025-04-01');