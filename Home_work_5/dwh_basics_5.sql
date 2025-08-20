CREATE TABLE dim_user (
    User_SK SERIAL PRIMARY KEY,          
    Source_UserID INT UNIQUE NOT NULL,  
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(255),
    RegistrationDate DATE
);
CREATE TABLE dim_song (
    Song_SK SERIAL PRIMARY KEY,         
    Source_SongID INT UNIQUE NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Artist VARCHAR(255),
    Album VARCHAR(255),
    Genre VARCHAR(50),
    DurationSec INT,                     
    ReleaseDate DATE
);
CREATE TABLE dim_date (
    Date_SK SERIAL PRIMARY KEY,          
    Source_DateID DATE UNIQUE NOT NULL, 
    Year INT,
    Month INT,
    Day INT
);
CREATE TABLE fact_playback (
    Playback_SK SERIAL PRIMARY KEY,   
    User_SK INT NOT NULL,                
    Song_SK INT NOT NULL,              
    Date_SK INT NOT NULL,              
    SecondsPlayed INT,                 
    IsCompleted BOOLEAN,                 
    IsSkipped BOOLEAN,                   
    LikeFlag BOOLEAN,                   
    StartTimestamp TIMESTAMP,            
    EndTimestamp TIMESTAMP,             
    SessionID VARCHAR(50),             
    CONSTRAINT fk_user FOREIGN KEY(User_SK) REFERENCES dim_user(User_SK),
    CONSTRAINT fk_song FOREIGN KEY(Song_SK) REFERENCES dim_song(Song_SK),
    CONSTRAINT fk_date FOREIGN KEY(Date_SK) REFERENCES dim_date(Date_SK)
);
-- Сколько треков воспроизведено в каждом месяце.
-- Помогает бизнесу видеть сезонные тренды. 
SELECT 
    dim_date.Year,
    dim_date.Month,
    COUNT(fact_playback.Playback_SK) AS TotalPlaybacks
FROM fact_playback
JOIN dim_date ON fact_playback.Date_SK = dim_date.Date_SK
GROUP BY dim_date.Year, dim_date.Month
ORDER BY dim_date.Year, dim_date.Month;
-- Сколько треков прослушал каждый пользователь и суммарное время.
-- Выявляет самых активных пользователей.
SELECT 
    dim_user.User_SK,
    dim_user.Username,
    COUNT(fact_playback.Playback_SK) AS TotalPlaybacks,
    SUM(fact_playback.SecondsPlayed) AS TotalSeconds
FROM fact_playback
JOIN dim_user ON fact_playback.User_SK = dim_user.User_SK
GROUP BY dim_user.User_SK, dim_user.Username
ORDER BY TotalPlaybacks DESC;
-- Топ 10 треков по количеству воспроизведений и лайкам.
-- Помогает бизнесу понять, какие треки наиболее популярны.
SELECT 
    dim_song.Song_SK,
    dim_song.Title,
    dim_song.Artist,
    COUNT(fact_playback.Playback_SK) AS TotalPlaybacks,
    SUM(CASE WHEN fact_playback.LikeFlag THEN 1 ELSE 0 END) AS TotalLikes
FROM fact_playback
JOIN dim_song ON fact_playback.Song_SK = dim_song.Song_SK
GROUP BY dim_song.Song_SK, dim_song.Title, dim_song.Artist
ORDER BY TotalPlaybacks DESC
LIMIT 10;
-- Жанры с наибольшим количеством прослушиваний и суммарным временем.
-- Показывает бизнес-тренды по жанрам.
SELECT 
    dim_song.Genre,
    COUNT(fact_playback.Playback_SK) AS TotalPlays,
    SUM(fact_playback.SecondsPlayed) AS TotalSeconds
FROM fact_playback
JOIN dim_song ON fact_playback.Song_SK = dim_song.Song_SK
GROUP BY dim_song.Genre
ORDER BY TotalPlays DESC;
-- Сколько времени пользователь слушает музыку каждый день.
-- Показывает среднее ежедневное время пользователей на платформе.
SELECT 
    fact_playback.User_SK,
    DATE(fact_playback.StartTimestamp) AS PlaybackDate,
    SUM(fact_playback.SecondsPlayed) AS TotalSecondsPerDay,
    ROUND(SUM(fact_playback.SecondsPlayed) / 60.0, 2) AS TotalMinutesPerDay
FROM fact_playback
GROUP BY fact_playback.User_SK, DATE(fact_playback.StartTimestamp)
ORDER BY fact_playback.User_SK, PlaybackDate;