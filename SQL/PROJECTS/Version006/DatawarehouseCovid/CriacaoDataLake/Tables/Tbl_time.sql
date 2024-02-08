CREATE TABLE [dbo].[Table2]
(
	[time_date_id] INT NOT NULL PRIMARY KEY,
	[date_code] VARCHAR(25) NOT NULL,
    [date_datetime] DATETIME NOT NULL,
    [origin] VARCHAR(200) NOT NULL, 
    [load_date] DATETIME NOT NULL
)
