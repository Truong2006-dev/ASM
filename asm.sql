USE master;
GO

-- 1. Xóa database cũ nếu có để làm mới
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'ASM')
BEGIN
    ALTER DATABASE ASM SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ASM;
END
GO

CREATE DATABASE ASM;
GO

USE ASM;
GO

-- 2. Tạo bảng Users
CREATE TABLE Users(
    Id VARCHAR(50) PRIMARY KEY,
    Password VARCHAR(50),
    Email VARCHAR(50),
    Fullname NVARCHAR(50),
    Admin BIT
);
GO

-- 3. Tạo bảng Video
-- LƯU Ý: Id chính là Youtube ID (11 ký tự), ví dụ: 'Q5gE5ODKsZk'
CREATE TABLE Video(
    Id VARCHAR(20) PRIMARY KEY,      -- Youtube ID
    Titile NVARCHAR(100),
    Poster NVARCHAR(255),            -- Link ảnh poster
    Views INT,
    Description NVARCHAR(MAX),
    Active BIT,
    Link VARCHAR(255)                -- Link Embed hoặc Watch
);
GO

-- 4. Tạo bảng Favorite
CREATE TABLE Favorite(
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId VARCHAR(50),
    VideoId VARCHAR(20),             -- Phải khớp kiểu dữ liệu với Video.Id
    LikeDate DATE,
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (VideoId) REFERENCES Video(Id)
);
GO

-- 5. Tạo bảng Share
CREATE TABLE Share (
    Id BIGINT IDENTITY(1,1) PRIMARY KEY,
    UserId VARCHAR(50) NOT NULL,
    VideoId VARCHAR(20) NOT NULL,    -- Phải khớp kiểu dữ liệu với Video.Id
    Emails VARCHAR(50),
    ShareDate DATE DEFAULT GETDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (VideoId) REFERENCES Video(Id)
);
GO

-- 6. Insert dữ liệu Users
INSERT INTO Users (Id, Password, Email, Fullname, Admin) VALUES
('U01', '123456', 'teo@gmail.com', N'Nguyễn Văn Tèo', 0),
('U02', '123456', 'ti@gmail.com', N'Nguyễn Văn Tí', 0),
('U03', '123456', 'hong@gmail.com', N'Lê Hồng', 0),
('U04', '123456', 'lan@gmail.com', N'Trần Thị Lan', 0),
('U05', '123456', 'admin@gmail.com', N'Quản Trị 1', 1),
('U06', '123456', 'minh@gmail.com', N'Trần Minh', 0),
('U07', '123456', 'ha@gmail.com', N'Phạm Thu Hà', 0),
('U08', '123456', 'kiet@gmail.com', N'Lý Kiệt', 0),
('U09', '123456', 'vy@gmail.com', N'Ngô Vy', 0),
('U10', '123456', 'duy@gmail.com', N'Hoàng Duy', 0);

-- 7. Insert dữ liệu Video (ĐÃ SỬA ID THÀNH YOUTUBE ID THẬT)
-- Quy tắc: Id lấy từ đoạn mã sau 'embed/' hoặc 'v=' trong link
INSERT INTO Video (Id, Titile, Poster, Views, Description, Active, Link) VALUES
('Q5gE5ODKsZk', N'Top 10 Most Satisfying Footage', 'https://img.youtube.com/vi/Q5gE5ODKsZk/hqdefault.jpg', 1000000, N'Compilation video', 1, 'https://www.youtube.com/embed/Q5gE5ODKsZk'),
('A74TOX803D0', N'How to Learn Java in 2024', 'https://img.youtube.com/vi/A74TOX803D0/hqdefault.jpg', 850000, N'Java tutorial', 1, 'https://www.youtube.com/embed/A74TOX803D0'),
('1ZYbU82GVz4', N'Relaxing Piano Music', 'https://img.youtube.com/vi/1ZYbU82GVz4/hqdefault.jpg', 5200000, N'Music for relaxation', 1, 'https://www.youtube.com/embed/1ZYbU82GVz4'),
('agetfT-ug1E', N'10 Linux Tricks for Developers', 'https://img.youtube.com/vi/agetfT-ug1E/hqdefault.jpg', 340000, N'Linux tips', 1, 'https://www.youtube.com/embed/agetfT-ug1E'),
('2ePf9rue1Ao', N'What is AI in 5 Minutes', 'https://img.youtube.com/vi/2ePf9rue1Ao/hqdefault.jpg', 900000, N'AI explanation', 1, 'https://www.youtube.com/embed/2ePf9rue1Ao'),
('hA6hldpSTF8', N'Avengers: Endgame Trailer', 'https://img.youtube.com/vi/hA6hldpSTF8/hqdefault.jpg', 135000000, N'Movie trailer', 1, 'https://www.youtube.com/embed/hA6hldpSTF8'),
('jfKfPfyJRdk', N'Lofi Hip Hop Radio', 'https://img.youtube.com/vi/jfKfPfyJRdk/hqdefault.jpg', 9999999, N'Lofi beats', 1, 'https://www.youtube.com/embed/jfKfPfyJRdk'),
('9t8P3KJtE5s', N'NASA James Webb First Image', 'https://img.youtube.com/vi/9t8P3KJtE5s/hqdefault.jpg', 7200000, N'Space discovery', 1, 'https://www.youtube.com/embed/9t8P3KJtE5s'),
('ZcQgYQY2hNw', N'Nhạc Chill TikTok 2024', 'https://img.youtube.com/vi/ZcQgYQY2hNw/hqdefault.jpg', 6000000, N'VN chill music', 1, 'https://www.youtube.com/embed/ZcQgYQY2hNw'),
('jWnp_GHSPdE', N'Cách Làm Bánh Mì Việt Nam', 'https://img.youtube.com/vi/jWnp_GHSPdE/hqdefault.jpg', 4500000, N'Cooking tutorial', 1, 'https://www.youtube.com/embed/jWnp_GHSPdE'),
('WY4k9uG5cKk', N'Beautiful Places in the World 4K', 'https://img.youtube.com/vi/WY4k9uG5cKk/hqdefault.jpg', 12000000, N'Nature landscapes', 1, 'https://www.youtube.com/embed/WY4k9uG5cKk'),
('G3e-cpL7ofc', N'Build Website with HTML CSS JS', 'https://img.youtube.com/vi/G3e-cpL7ofc/hqdefault.jpg', 700000, N'Web dev tutorial', 1, 'https://www.youtube.com/embed/G3e-cpL7ofc'),
('xuCn8ux2gbs', N'History of the Entire World', 'https://img.youtube.com/vi/xuCn8ux2gbs/hqdefault.jpg', 80000000, N'Funny history', 1, 'https://www.youtube.com/embed/xuCn8ux2gbs'),
('GoJsr4IwCm4', N'Why We Age', 'https://img.youtube.com/vi/GoJsr4IwCm4/hqdefault.jpg', 6000000, N'Science video', 1, 'https://www.youtube.com/embed/GoJsr4IwCm4'),
('6avJHaC3C2U', N'Programming Meme Compilation', 'https://img.youtube.com/vi/6avJHaC3C2U/hqdefault.jpg', 5000000, N'Coding memes', 1, 'https://www.youtube.com/embed/6avJHaC3C2U'),
('Z4TXCZG_NEY', N'SpaceX Starship Flight Test', 'https://img.youtube.com/vi/Z4TXCZG_NEY/hqdefault.jpg', 9000000, N'Rocket launch', 1, 'https://www.youtube.com/embed/Z4TXCZG_NEY'),
('hY7m5jjJ9mM', N'Funny Cat Videos', 'https://img.youtube.com/vi/hY7m5jjJ9mM/hqdefault.jpg', 30000000, N'Funny cats', 1, 'https://www.youtube.com/embed/hY7m5jjJ9mM'),
('AmC9SmCBUj4', N'How to Cook Perfect Steak', 'https://img.youtube.com/vi/AmC9SmCBUj4/hqdefault.jpg', 25000000, N'Gordon Ramsay', 1, 'https://www.youtube.com/embed/AmC9SmCBUj4'),
('DW8ZP8kzsD8', N'Rain Sounds for Sleeping', 'https://img.youtube.com/vi/DW8ZP8kzsD8/hqdefault.jpg', 18000000, N'Relaxing rain', 1, 'https://www.youtube.com/embed/DW8ZP8kzsD8'),
('_uQrJ0TkZlc', N'Python Full Course 12 Hours', 'https://img.youtube.com/vi/_uQrJ0TkZlc/hqdefault.jpg', 4000000, N'Python tutorial', 1, 'https://www.youtube.com/embed/_uQrJ0TkZlc'),
('QqsLTNkzvaY', N'Black Holes Delete Universe', 'https://img.youtube.com/vi/QqsLTNkzvaY/hqdefault.jpg', 15500000, N'Kurzgesagt', 1, 'https://www.youtube.com/embed/QqsLTNkzvaY'),
('jIMihpDmBpY', N'15 Amazing Science Experiments', 'https://img.youtube.com/vi/jIMihpDmBpY/hqdefault.jpg', 9500000, N'Experiments', 1, 'https://www.youtube.com/embed/jIMihpDmBpY'),
('hdI2bqOjy3c', N'Javascript Crash Course', 'https://img.youtube.com/vi/hdI2bqOjy3c/hqdefault.jpg', 2000000, N'JS tutorial', 1, 'https://www.youtube.com/embed/hdI2bqOjy3c'),
('6x0WgB2b2p4', N'Best Minecraft Build Ideas', 'https://img.youtube.com/vi/6x0WgB2b2p4/hqdefault.jpg', 5000000, N'Minecraft', 1, 'https://www.youtube.com/embed/6x0WgB2b2p4'),
('4Tr0otuiQuU', N'90 Minute Timer Soft Music', 'https://img.youtube.com/vi/4Tr0otuiQuU/hqdefault.jpg', 4500000, N'Timer', 1, 'https://www.youtube.com/embed/4Tr0otuiQuU'),
('8cP7snhFo2E', N'Velocity Edit Tutorial', 'https://img.youtube.com/vi/8cP7snhFo2E/hqdefault.jpg', 1200000, N'Editing', 1, 'https://www.youtube.com/embed/8cP7snhFo2E'),
('wp43OdtAAkM', N'Deep Focus Study Music', 'https://img.youtube.com/vi/wp43OdtAAkM/hqdefault.jpg', 6800000, N'Focus music', 1, 'https://www.youtube.com/embed/wp43OdtAAkM'),
('8C-s9iXHdZk', N'Why Leaving Windows for Linux', 'https://img.youtube.com/vi/8C-s9iXHdZk/hqdefault.jpg', 2000000, N'Linux OS', 1, 'https://www.youtube.com/embed/8C-s9iXHdZk'),
-- Các video nhạc mới (giữ nguyên ID chuẩn)
('ekr2nIex040', N'ROSÉ & Bruno Mars - APT.', 'https://img.youtube.com/vi/ekr2nIex040/hqdefault.jpg', 350000000, N'Official Music Video', 1, 'https://www.youtube.com/embed/ekr2nIex040'),
('kPa7bsKwL-c', N'Lady Gaga, Bruno Mars - Die With A Smile', 'https://img.youtube.com/vi/kPa7bsKwL-c/hqdefault.jpg', 280000000, N'Ballad', 1, 'https://www.youtube.com/embed/kPa7bsKwL-c'),
('dhDdW0mwyXg', N'Yêu Người Có Ước Mơ', 'https://img.youtube.com/vi/dhDdW0mwyXg/hqdefault.jpg', 30000000, N'Nhạc trẻ', 1, 'https://www.youtube.com/embed/dhDdW0mwyXg'),
('abPmZCZZrFA', N'SƠN TÙNG M-TP | ĐỪNG LÀM TRÁI TIM ANH ĐAU', 'https://img.youtube.com/vi/abPmZCZZrFA/hqdefault.jpg', 161000000, N'V-Pop', 1, 'https://www.youtube.com/embed/abPmZCZZrFA');

-- 8. Insert dữ liệu Favorite (CẬP NHẬT ID MỚI)
-- V01 -> Q5gE5ODKsZk
-- V02 -> A74TOX803D0
-- V03 -> 1ZYbU82GVz4
-- V04 -> agetfT-ug1E
-- V05 -> 2ePf9rue1Ao
INSERT INTO Favorite (UserId, VideoId, LikeDate) VALUES
('U01', 'Q5gE5ODKsZk', '2024-01-10'),
('U02', '1ZYbU82GVz4', '2024-01-12'),
('U03', 'Q5gE5ODKsZk', '2024-01-15'),
('U04', '2ePf9rue1Ao', '2024-01-16'),
('U05', 'A74TOX803D0', '2024-01-18'),
('U06', 'Q5gE5ODKsZk', '2024-01-20'),
('U07', '1ZYbU82GVz4', '2024-01-21'),
('U08', 'agetfT-ug1E', '2024-01-22'),
('U09', 'A74TOX803D0', '2024-01-24'),
('U10', '2ePf9rue1Ao', '2024-01-26');

-- 9. Insert dữ liệu Share (CẬP NHẬT ID MỚI)
INSERT INTO Share (UserId, VideoId, Emails, ShareDate) VALUES
('U01', 'Q5gE5ODKsZk', 'friend1@gmail.com', '2024-01-05'),
('U02', 'A74TOX803D0', 'friend2@gmail.com', '2024-01-07'),
('U03', '1ZYbU82GVz4', 'friend3@gmail.com', '2024-01-08'),
('U04', 'agetfT-ug1E', 'friend4@gmail.com', '2024-01-09'),
('U05', '2ePf9rue1Ao', 'friend5@gmail.com', '2024-01-10'),
('U06', 'hA6hldpSTF8', 'friend6@gmail.com', '2024-01-11'),
('U07', 'jfKfPfyJRdk', 'friend7@gmail.com', '2024-01-12'),
('U08', '9t8P3KJtE5s', 'friend8@gmail.com', '2024-01-13'),
('U09', 'ZcQgYQY2hNw', 'friend9@gmail.com', '2024-01-14'),
('U10', 'jWnp_GHSPdE', 'friend10@gmail.com', '2024-01-15');

GO

-- 1. SP cho Tab "FAVORITES" (Thống kê tổng hợp)

IF OBJECT_ID('sp_ReportFavorites') IS NOT NULL
    DROP PROC sp_ReportFavorites
GO
CREATE PROC sp_ReportFavorites
AS
BEGIN
    SELECT 
        v.Titile AS 'Group',
        COUNT(f.Id) AS 'Likes',
        MAX(f.LikeDate) AS 'Newest',
        MIN(f.LikeDate) AS 'Oldest'
    FROM Video v
    LEFT JOIN Favorite f ON v.Id = f.VideoId
    GROUP BY v.Titile
    HAVING COUNT(f.Id) > 0 
    ORDER BY 'Likes' DESC
END
GO

-- 2. SP cho Tab "FAVORITE USERS" (Ai thích video nào?)
IF OBJECT_ID('sp_ReportFavoriteUsers') IS NOT NULL
    DROP PROC sp_ReportFavoriteUsers
GO
CREATE PROC sp_ReportFavoriteUsers
    @VideoId VARCHAR(20)
AS
BEGIN
    SELECT 
        u.Id AS 'Username',
        u.Fullname AS 'Fullname',
        u.Email AS 'Email',
        f.LikeDate AS 'FavoriteDate'
    FROM Favorite f
    JOIN Users u ON f.UserId = u.Id
    WHERE f.VideoId = @VideoId
END
GO

-- 3. SP cho Tab "SHARED FRIENDS" (Ai chia sẻ cho ai?)
IF OBJECT_ID('sp_ReportSharedFriends') IS NOT NULL
    DROP PROC sp_ReportSharedFriends
GO
CREATE PROC sp_ReportSharedFriends
    @VideoId VARCHAR(20)
AS
BEGIN
    SELECT 
        u.Fullname AS 'SenderName',
        u.Email AS 'SenderEmail',
        s.Emails AS 'ReceiverEmail',
        s.ShareDate AS 'SentDate'
    FROM Share s
    JOIN Users u ON s.UserId = u.Id
    WHERE s.VideoId = @VideoId
END
GO

-- Tab 1
EXEC sp_ReportFavorites;

-- Tab 2 (Thay ID video vào sau)
EXEC sp_ReportFavoriteUsers 'Q5gE5ODKsZk';

-- Tab 3 (Thay ID video vào sau)
EXEC sp_ReportSharedFriends 'Q5gE5ODKsZk';