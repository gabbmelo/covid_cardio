CREATE TABLE [dbo].[Tbl_geo]
(
	[geo_country_id] INT NOT NULL PRIMARY KEY,
	[continent_code] INT NOT NULL,
    [continent_desc] VARCHAR(50) NOT NULL,
    [sub_region_code] INT NOT NULL,
    [sub_region_desc] VARCHAR(50) NOT NULL,
    [country_code] VARCHAR(3) NOT NULL,
    [country_desc] VARCHAR(200) NOT NULL,
    [gdp_per_capita] FLOAT NOT NULL,
    [atr_65_plus] FLOAT NOT NULL,
    [atr_hosp_beds] FLOAT NOT NULL,
    [atr_population] INT NOT NULL,
    [origin] VARCHAR(200) NOT NULL, 
    [load_date] DATETIME NOT NULL
)
