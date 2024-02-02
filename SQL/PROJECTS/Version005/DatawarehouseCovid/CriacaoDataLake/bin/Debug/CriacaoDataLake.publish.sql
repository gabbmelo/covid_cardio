/*
Script de implantação para DL_COVID

Este código foi gerado por uma ferramenta.
As alterações feitas nesse arquivo poderão causar comportamento incorreto e serão perdidas se
o código for gerado novamente.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DL_COVID"
:setvar DefaultFilePrefix "DL_COVID"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER2022\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER2022\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detecta o modo SQLCMD e desabilita a execução do script se o modo SQLCMD não tiver suporte.
Para reabilitar o script após habilitar o modo SQLCMD, execute o comando a seguir:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'O modo SQLCMD deve ser habilitado para executar esse script com êxito.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'A operação de refatoração Renomear com chave a58d4cd2-eb09-4db5-b092-451b9a5d98c8, 7a8a1894-91de-48a1-a0e9-a5651609f170 foi ignorada; o elemento [dbo].[Tbl_economic].[Id] (SqlSimpleColumn) não será renomeado para level_gdp_per_capita';


GO
PRINT N'A operação de refatoração Renomear com chave d9a94bd2-3fa3-4a8b-a61d-4b2bf5fee3f3 foi ignorada; o elemento [dbo].[Tbl_economic].[atr_gdp_per_capita] (SqlSimpleColumn) não será renomeado para desc_level_gdp_per_capita';


GO
PRINT N'Criando Tabela [dbo].[Table1]...';


GO
CREATE TABLE [dbo].[Table1] (
    [social_hosp_bed_level_id] INT           NOT NULL,
    [hosp_beds_code]           VARCHAR (4)   NOT NULL,
    [hosp_bed_level_desc]      VARCHAR (200) NOT NULL,
    [atr_hosp_beds]            FLOAT (53)    NOT NULL,
    [atr_65_plus]              FLOAT (53)    NOT NULL,
    [origin]                   VARCHAR (200) NOT NULL,
    [load_date]                DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([social_hosp_bed_level_id] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Table2]...';


GO
CREATE TABLE [dbo].[Table2] (
    [time_date_id]        INT           NOT NULL,
    [day_code]            VARCHAR (25)  NOT NULL,
    [date_code]           DATETIME      NOT NULL,
    [atr_day_of_the_week] VARCHAR (50)  NOT NULL,
    [atr_weekday]         BIT           NOT NULL,
    [month_code]          VARCHAR (25)  NOT NULL,
    [month_desc]          VARCHAR (200) NOT NULL,
    [quarter_code]        VARCHAR (25)  NOT NULL,
    [desc_quarter]        VARCHAR (200) NOT NULL,
    [semester_code]       VARCHAR (25)  NOT NULL,
    [desc_semester]       VARCHAR (200) NOT NULL,
    [year_code]           VARCHAR (25)  NOT NULL,
    [origin]              VARCHAR (200) NOT NULL,
    [load_date]           DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([time_date_id] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Tbl_economic]...';


GO
CREATE TABLE [dbo].[Tbl_economic] (
    [level_gdp_per_capita]      INT           NOT NULL,
    [desc_level_gdp_per_capita] VARCHAR (3)   NOT NULL,
    [gdp_level_desc]            VARCHAR (200) NOT NULL,
    [gdp_per_capita]            FLOAT (53)    NOT NULL,
    [atr_population]            INT           NOT NULL,
    [origin]                    VARCHAR (200) NOT NULL,
    [load_date]                 DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([level_gdp_per_capita] ASC)
);


GO
PRINT N'Criando Tabela [dbo].[Tbl_geo]...';


GO
CREATE TABLE [dbo].[Tbl_geo] (
    [geo_country_id]  INT           NOT NULL,
    [sub_region_code] INT           NOT NULL,
    [continent_code]  INT           NOT NULL,
    [country_code]    VARCHAR (3)   NOT NULL,
    [country_desc]    VARCHAR (200) NOT NULL,
    [sub_region_desc] VARCHAR (50)  NOT NULL,
    [continent_desc]  VARCHAR (50)  NOT NULL,
    [origin]          VARCHAR (200) NOT NULL,
    [load_date]       DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([geo_country_id] ASC)
);


GO
-- Etapa de refatoração para atualizar o servidor de destino com logs de transação implantados

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a58d4cd2-eb09-4db5-b092-451b9a5d98c8')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a58d4cd2-eb09-4db5-b092-451b9a5d98c8')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '7a8a1894-91de-48a1-a0e9-a5651609f170')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('7a8a1894-91de-48a1-a0e9-a5651609f170')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'd9a94bd2-3fa3-4a8b-a61d-4b2bf5fee3f3')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('d9a94bd2-3fa3-4a8b-a61d-4b2bf5fee3f3')

GO

GO
PRINT N'Atualização concluída.';


GO
