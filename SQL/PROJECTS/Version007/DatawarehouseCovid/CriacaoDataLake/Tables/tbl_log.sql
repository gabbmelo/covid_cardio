CREATE TABLE [dbo].[tbl_log]
(
	[date] DATETIME NOT NULL PRIMARY KEY, 
    [message] VARCHAR(255) NULL, 
    [result] VARCHAR(30) NULL
)
