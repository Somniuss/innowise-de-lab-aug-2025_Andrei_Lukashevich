-- Таблица пользователей
CREATE TABLE dim_user (
    User_SK SERIAL PRIMARY KEY,             
    Source_UserID INT UNIQUE NOT NULL,    
    Username VARCHAR(100) NOT NULL,
    Email VARCHAR(255),
    RegistrationDate DATE
);

-- Таблица треков
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

-- Таблица качества стрима
CREATE TABLE dim_stream_quality (
    StreamQuality_SK SERIAL PRIMARY KEY,    
    StreamQuality_ID VARCHAR(50) UNIQUE NOT NULL, 
    Format VARCHAR(50),
    Bitrate INT
);

-- Таблица фактов воспроизведения
CREATE TABLE fact_playback (
    Playback_SK SERIAL PRIMARY KEY,                 
    User_SK INT NOT NULL,                          
    Song_SK INT NOT NULL,                          
    StreamQuality_SK INT NOT NULL,               
    SecondsPlayed INT,
    IsCompleted BOOLEAN,
    IsSkipped BOOLEAN,
    LikeFlag BOOLEAN,
    StartTimestamp TIMESTAMP WITH TIME ZONE,        
    EndTimestamp TIMESTAMP WITH TIME ZONE,           
    SessionID VARCHAR(50),
    CONSTRAINT fk_user FOREIGN KEY(User_SK) REFERENCES dim_user(User_SK),
    CONSTRAINT fk_song FOREIGN KEY(Song_SK) REFERENCES dim_song(Song_SK),
    CONSTRAINT fk_stream_quality FOREIGN KEY(StreamQuality_SK) REFERENCES dim_stream_quality(StreamQuality_SK)
);

-- Примеры аналитических запросов

-- Сколько треков воспроизведено в каждом месяце.
-- Помогает бизнесу видеть сезонные тренды.
SELECT
    EXTRACT(YEAR FROM StartTimestamp AT TIME ZONE 'UTC') AS Year,
    EXTRACT(MONTH FROM StartTimestamp AT TIME ZONE 'UTC') AS Month,
    COUNT(Playback_SK) AS TotalPlaybacks
FROM fact_playback
GROUP BY Year, Month
ORDER BY Year, Month;

-- Сколько треков прослушал каждый пользователь и суммарное время.
-- Выявляет самых активных пользователей.
SELECT
    u.User_SK,
    u.Username,
    COUNT(f.Playback_SK) AS TotalPlaybacks,
    SUM(f.SecondsPlayed) AS TotalSeconds
FROM fact_playback f
JOIN dim_user u ON f.User_SK = u.User_SK
GROUP BY u.User_SK, u.Username
ORDER BY TotalPlaybacks DESC;

-- Топ 10 треков по количеству воспроизведений и лайкам.
-- Помогает бизнесу понять, какие треки наиболее популярны.
SELECT 
    s.Song_SK,
    s.Title,
    s.Artist,
    COUNT(f.Playback_SK) AS TotalPlaybacks,
    SUM(CASE WHEN f.LikeFlag THEN 1 ELSE 0 END) AS TotalLikes
FROM fact_playback f
JOIN dim_song s ON f.Song_SK = s.Song_SK
GROUP BY s.Song_SK, s.Title, s.Artist
ORDER BY TotalPlaybacks DESC
LIMIT 10;

-- Жанры с наибольшим количеством прослушиваний и суммарным временем.
-- Показывает бизнес-тренды по жанрам.
SELECT 
    s.Genre,
    COUNT(f.Playback_SK) AS TotalPlays,
    SUM(f.SecondsPlayed) AS TotalSeconds
FROM fact_playback f
JOIN dim_song s ON f.Song_SK = s.Song_SK
GROUP BY s.Genre
ORDER BY TotalPlays DESC;

-- Сколько времени пользователь слушает музыку каждый день.
-- Показывает среднее ежедневное время пользователей на платформе.
SELECT 
    f.User_SK,
    DATE(f.StartTimestamp AT TIME ZONE 'UTC') AS playback_date,
    SUM(f.SecondsPlayed) AS total_seconds_per_day,
    ROUND(SUM(f.SecondsPlayed) / 60.0, 2) AS total_minutes_per_day
FROM fact_playback f
GROUP BY f.User_SK, DATE(f.StartTimestamp AT TIME ZONE 'UTC')
ORDER BY f.User_SK, playback_date;

-- Предпочтительный формат стрима
-- Показывает, какие форматы предпочитают пользователи
SELECT 
    sq.Format,
    sq.Bitrate,
    COUNT(f.Playback_SK) AS TotalPlaybacks,
    SUM(f.SecondsPlayed) AS TotalSeconds
FROM fact_playback f
JOIN dim_stream_quality sq ON f.StreamQuality_SK = sq.StreamQuality_SK
GROUP BY sq.Format, sq.Bitrate
ORDER BY TotalPlaybacks DESC;