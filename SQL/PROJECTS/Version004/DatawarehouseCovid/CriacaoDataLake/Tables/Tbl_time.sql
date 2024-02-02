CREATE TABLE [dbo].[Table2]
(
	[time_date_id] INT NOT NULL PRIMARY KEY,
	[day_code] VARCHAR(25) NOT NULL,
    [date_code] DATETIME NOT NULL,
    [atr_day_of_the_week] VARCHAR(50) NOT NULL,
    [atr_weekday] BIT NOT NULL,
    [month_code] VARCHAR(25) NOT NULL,
    [month_desc] VARCHAR(200) NOT NULL,
    [quarter_code] VARCHAR(25) NOT NULL,
    [desc_quarter] VARCHAR(200) NOT NULL,
    [semester_code] VARCHAR(25) NOT NULL,
    [desc_semester] VARCHAR(200) NOT NULL,
    [year_code] VARCHAR(25) NOT NULL,
    [origin] VARCHAR(200) NOT NULL, 
    [load_date] DATETIME NOT NULL
)
