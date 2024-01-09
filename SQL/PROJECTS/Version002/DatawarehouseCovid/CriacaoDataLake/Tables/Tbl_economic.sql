CREATE TABLE [dbo].[Tbl_economic]
(
	[level_gdp_per_capita] INT NOT NULL PRIMARY KEY, 
    [desc_level_gdp_per_capita] VARCHAR(3) NOT NULL,
	[gdp_level_desc] VARCHAR(200) NOT NULL,
    [gdp_per_capita] FLOAT NOT NULL,
    [atr_population] INT NOT NULL, 
    [origin] VARCHAR(200) NOT NULL, 
    [load_date] DATETIME NOT NULL
)
