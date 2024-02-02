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
/*
Ignorando a coluna [dbo].[Tbl_economic].[atr_population]; poderá ocorrer perda de dados.

Ignorando a coluna [dbo].[Tbl_economic].[gdp_per_capita]; poderá ocorrer perda de dados.
*/

IF EXISTS (select top 1 1 from [dbo].[Tbl_economic])
    RAISERROR (N'Linhas foram detectadas. A atualização de esquema está sendo encerrada porque pode ocorrer perda de dados.', 16, 127) WITH NOWAIT

GO
/*
A coluna [dbo].[Tbl_geo].[atr_65_plus] na tabela [dbo].[Tbl_geo] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.

A coluna [dbo].[Tbl_geo].[atr_hosp_beds] na tabela [dbo].[Tbl_geo] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.

A coluna [dbo].[Tbl_geo].[atr_population] na tabela [dbo].[Tbl_geo] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.

A coluna [dbo].[Tbl_geo].[gdp_per_capita] na tabela [dbo].[Tbl_geo] deve ser adicionada, mas a coluna não possui valor padrão e não permite valores NULL. Se a tabela contiver dados, o script ALTER não funcionará. Para evitar o problema, você deve: adicionar um valor padrão para a coluna, marcá-la para permitir valores NULL ou habilitar a geração de padrões inteligentes como uma opção de implantação.
*/

IF EXISTS (select top 1 1 from [dbo].[Tbl_geo])
    RAISERROR (N'Linhas foram detectadas. A atualização de esquema está sendo encerrada porque pode ocorrer perda de dados.', 16, 127) WITH NOWAIT

GO
PRINT N'Alterando Tabela [dbo].[Tbl_economic]...';


GO
ALTER TABLE [dbo].[Tbl_economic] DROP COLUMN [atr_population], COLUMN [gdp_per_capita];


GO
PRINT N'Iniciando a recompilação da tabela [dbo].[Tbl_geo]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Tbl_geo] (
    [geo_country_id]  INT           NOT NULL,
    [continent_code]  INT           NOT NULL,
    [continent_desc]  VARCHAR (50)  NOT NULL,
    [sub_region_code] INT           NOT NULL,
    [sub_region_desc] VARCHAR (50)  NOT NULL,
    [country_code]    VARCHAR (3)   NOT NULL,
    [country_desc]    VARCHAR (200) NOT NULL,
    [gdp_per_capita]  FLOAT (53)    NOT NULL,
    [atr_65_plus]     FLOAT (53)    NOT NULL,
    [atr_hosp_beds]   FLOAT (53)    NOT NULL,
    [atr_population]  INT           NOT NULL,
    [origin]          VARCHAR (200) NOT NULL,
    [load_date]       DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([geo_country_id] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Tbl_geo])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_Tbl_geo] ([geo_country_id], [sub_region_code], [continent_code], [country_code], [country_desc], [sub_region_desc], [continent_desc], [origin], [load_date])
        SELECT   [geo_country_id],
                 [sub_region_code],
                 [continent_code],
                 [country_code],
                 [country_desc],
                 [sub_region_desc],
                 [continent_desc],
                 [origin],
                 [load_date]
        FROM     [dbo].[Tbl_geo]
        ORDER BY [geo_country_id] ASC;
    END

DROP TABLE [dbo].[Tbl_geo];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Tbl_geo]', N'Tbl_geo';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Criando Tabela [dbo].[Table1]...';


GO
CREATE TABLE [dbo].[Table1] (
    [social_hosp_bed_level_id] INT           NOT NULL,
    [hosp_beds_code]           VARCHAR (4)   NOT NULL,
    [hosp_bed_level_desc]      VARCHAR (200) NOT NULL,
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
PRINT N'Criando Tabela [dbo].[Tbl_elder_pop]...';


GO
CREATE TABLE [dbo].[Tbl_elder_pop] (
    [elder_population_level_id] INT           NOT NULL,
    [elder_pop_level_code]      VARCHAR (5)   NOT NULL,
    [elder_pop_level_desc]      VARCHAR (200) NOT NULL,
    [origin]                    VARCHAR (200) NOT NULL,
    [load_date]                 DATETIME      NOT NULL,
    PRIMARY KEY CLUSTERED ([elder_population_level_id] ASC)
);


GO
PRINT N'Atualização concluída.';


GO
