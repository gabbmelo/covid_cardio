CREATE TABLE [dbo].[Tbl_elder_pop]
(
	[elder_population_level_id] INT NOT NULL PRIMARY KEY,
	[elder_pop_level_code] VARCHAR(5) NOT NULL,
    [elder_pop_level_desc] VARCHAR(200) NOT NULL,
	[origin] VARCHAR(200) NOT NULL, 
    [load_date] DATETIME NOT NULL
)
