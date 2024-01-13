CREATE TABLE [dbo].[Table1]
(
	[social_hosp_bed_level_id] INT NOT NULL PRIMARY KEY,
	[hosp_beds_code] VARCHAR(4) NOT NULL,
    [hosp_bed_level_desc] VARCHAR(200) NOT NULL,
    [origin] VARCHAR(200) NOT NULL, 
    [load_date] DATETIME NOT NULL
)
