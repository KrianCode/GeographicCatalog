-- =============================================
-- ПОЛНЫЙ КОД БАЗЫ ДАННЫХ ГОСУДАРСТВЕННОГО КАТАЛОГА
-- ВСЕ ПРЕДОСТАВЛЕННЫЕ ДАННЫЕ ВСТАВЛЕНЫ (ОКОНЧАТЕЛЬНАЯ ИСПРАВЛЕННАЯ ВЕРСИЯ)
-- =============================================

USE master;
GO

USE GeographicCatalogDB;
GO
-- =============================================
-- СОЗДАНИЕ ВНЕШНИХ КЛЮЧЕЙ
-- =============================================

PRINT 'Создание внешних ключей...';
GO

-- Внешние ключи для kn_ra
ALTER TABLE kn_ra
ADD CONSTRAINT FK_kn_ra_ID_OBL FOREIGN KEY (ID_OBL) REFERENCES kn_obl(ID_OBL);
GO

-- Внешние ключи для kn_dbate (сначала отключаем проверку, потом включаем)
ALTER TABLE kn_dbate WITH NOCHECK
ADD CONSTRAINT FK_kn_dbate_ID_RODATE FOREIGN KEY (ID_RODATE) REFERENCES kn_rodate(ID_RODATE);
GO

ALTER TABLE kn_dbate WITH NOCHECK
ADD CONSTRAINT FK_kn_dbate_ID_OBL FOREIGN KEY (ID_OBL) REFERENCES kn_obl(ID_OBL);
GO

ALTER TABLE kn_dbate WITH NOCHECK
ADD CONSTRAINT FK_kn_dbate_ID_RA FOREIGN KEY (ID_RA) REFERENCES kn_ra(ID_RA);
GO

-- Включаем проверку ограничений для существующих данных
ALTER TABLE kn_dbate CHECK CONSTRAINT FK_kn_dbate_ID_RODATE;
ALTER TABLE kn_dbate CHECK CONSTRAINT FK_kn_dbate_ID_OBL;
ALTER TABLE kn_dbate CHECK CONSTRAINT FK_kn_dbate_ID_RA;
GO

-- Внешние ключи для таблиц, ссылающихся на kn_dbate по KOD_ATE
ALTER TABLE kn_atedrnamebel WITH NOCHECK
ADD CONSTRAINT FK_kn_atedrnamebel_KOD_ATE FOREIGN KEY (KOD_ATE) REFERENCES kn_dbate(KOD_ATE);
GO

ALTER TABLE kn_atedrnamerus WITH NOCHECK
ADD CONSTRAINT FK_kn_atedrnamerus_KOD_ATE FOREIGN KEY (KOD_ATE) REFERENCES kn_dbate(KOD_ATE);
GO

ALTER TABLE kn_hchangeate WITH NOCHECK
ADD CONSTRAINT FK_kn_hchangeate_KOD_ATE FOREIGN KEY (KOD_ATE) REFERENCES kn_dbate(KOD_ATE);
GO

ALTER TABLE kn_hpopular WITH NOCHECK
ADD CONSTRAINT FK_kn_hpopular_KOD_ATE FOREIGN KEY (KOD_ATE) REFERENCES kn_dbate(KOD_ATE);
GO

-- Включаем проверку
ALTER TABLE kn_atedrnamebel CHECK CONSTRAINT FK_kn_atedrnamebel_KOD_ATE;
ALTER TABLE kn_atedrnamerus CHECK CONSTRAINT FK_kn_atedrnamerus_KOD_ATE;
ALTER TABLE kn_hchangeate CHECK CONSTRAINT FK_kn_hchangeate_KOD_ATE;
ALTER TABLE kn_hpopular CHECK CONSTRAINT FK_kn_hpopular_KOD_ATE;
GO

-- Внешние ключи для kn_dbair
ALTER TABLE kn_dbair WITH NOCHECK
ADD CONSTRAINT FK_kn_dbair_OBL FOREIGN KEY (OBL) REFERENCES kn_obl(ID_OBL);
GO

ALTER TABLE kn_dbair CHECK CONSTRAINT FK_kn_dbair_OBL;
GO

-- Внешние ключи для kn_dbrw
ALTER TABLE kn_dbrw WITH NOCHECK
ADD CONSTRAINT FK_kn_dbrw_CATEGORY FOREIGN KEY (CATEGORY) REFERENCES kn_category(ID_CATEGOR);
GO

ALTER TABLE kn_dbrw WITH NOCHECK
ADD CONSTRAINT FK_kn_dbrw_OBL FOREIGN KEY (OBL) REFERENCES kn_obl(ID_OBL);
GO

ALTER TABLE kn_dbrw CHECK CONSTRAINT FK_kn_dbrw_CATEGORY;
ALTER TABLE kn_dbrw CHECK CONSTRAINT FK_kn_dbrw_OBL;
GO

-- Внешние ключи для kn_dbfgo
ALTER TABLE kn_dbfgo WITH NOCHECK
ADD CONSTRAINT FK_kn_dbfgo_RODFGO FOREIGN KEY (RODFGO) REFERENCES kn_rodfgo(ID_RODFGO);
GO

ALTER TABLE kn_dbfgo WITH NOCHECK
ADD CONSTRAINT FK_kn_dbfgo_OBL FOREIGN KEY (OBL) REFERENCES kn_obl(ID_OBL);
GO

ALTER TABLE kn_dbfgo CHECK CONSTRAINT FK_kn_dbfgo_RODFGO;
ALTER TABLE kn_dbfgo CHECK CONSTRAINT FK_kn_dbfgo_OBL;
GO

PRINT 'Все внешние ключи созданы.';
GO

-- =============================================
-- СОЗДАНИЕ ИНДЕКСОВ
-- =============================================

PRINT 'Создание индексов для оптимизации...';
GO

-- Индексы для kn_dbate
CREATE INDEX IX_kn_dbate_KOD_ATE ON kn_dbate(KOD_ATE);
CREATE INDEX IX_kn_dbate_NAMERUS ON kn_dbate(NAMERUS);
CREATE INDEX IX_kn_dbate_NAMEBEL ON kn_dbate(NAMEBEL);
CREATE INDEX IX_kn_dbate_ID_OBL ON kn_dbate(ID_OBL);
CREATE INDEX IX_kn_dbate_ID_RA ON kn_dbate(ID_RA);
CREATE INDEX IX_kn_dbate_NOMENKLAT ON kn_dbate(NOMENKLAT);
GO

-- Индексы для kn_dbair
CREATE INDEX IX_kn_dbair_NAMERUS ON kn_dbair(NAMERUS);
CREATE INDEX IX_kn_dbair_NAMEBEL ON kn_dbair(NAMEBEL);
CREATE INDEX IX_kn_dbair_OBL ON kn_dbair(OBL);
GO

-- Индексы для kn_dbrw
CREATE INDEX IX_kn_dbrw_NAMERUS ON kn_dbrw(NAMERUS);
CREATE INDEX IX_kn_dbrw_NAMEBEL ON kn_dbrw(NAMEBEL);
CREATE INDEX IX_kn_dbrw_ECP ON kn_dbrw(ECP);
CREATE INDEX IX_kn_dbrw_OBL ON kn_dbrw(OBL);
GO

-- Индексы для kn_dbfgo
CREATE INDEX IX_kn_dbfgo_NAMERUS ON kn_dbfgo(NAMERUS);
CREATE INDEX IX_kn_dbfgo_NAMEBEL ON kn_dbfgo(NAMEBEL);
CREATE INDEX IX_kn_dbfgo_OBL ON kn_dbfgo(OBL);
GO

-- Индексы для таблиц исторических изменений
CREATE INDEX IX_kn_hchangeate_KOD_ATE ON kn_hchangeate(KOD_ATE);
CREATE INDEX IX_kn_hchangeate_REDATE ON kn_hchangeate(REDATE);
CREATE INDEX IX_kn_hpopular_KOD_ATE ON kn_hpopular(KOD_ATE);
CREATE INDEX IX_kn_hpopular_DATACENSUS ON kn_hpopular(DATACENSUS);
GO

PRINT 'Индексы созданы.';
GO

-- =============================================
-- СОЗДАНИЕ ПРЕДСТАВЛЕНИЙ
-- =============================================

PRINT 'Создание полезных представлений...';
GO

-- 1. Представление для просмотра населенных пунктов с деталями
CREATE VIEW vw_Settlements_Detailed
AS
SELECT
b.KOD_ATE,
b.NAMERUS AS NameRu,
b.NAMEBEL AS NameBe,
b.NOMENKLAT,
b.X_WGS AS Longitude,
b.Y_WGS AS Latitude,
o.OBL AS Region,
r.RA AS District,
b.SOVET AS Council,
rt.RATENAME AS Type,
b.EXISTENCE AS Status,
b.SINFORUS AS InfoSourceRu,
b.SINFOBEL AS InfoSourceBe,
b.CreatedDate,
b.ModifiedDate
FROM kn_dbate b
LEFT JOIN kn_obl o ON b.ID_OBL = o.ID_OBL
LEFT JOIN kn_ra r ON b.ID_RA = r.ID_RA
LEFT JOIN kn_rodate rt ON b.ID_RODATE = rt.ID_RODATE;
GO

-- 2. Представление для аэропортов
CREATE VIEW vw_Airports_Detailed
AS
SELECT
a.ID_AIR,
a.NAMERUS AS NameRu,
a.NAMEBEL AS NameBe,
a.CATEGORY,
o.OBL AS Region,
a.GEOPR AS Location,
a.NOMENKLAT,
a.X_WGS AS Longitude,
a.Y_WGS AS Latitude,
a.IATA_Code,
a.ICAO_Code,
a.CreatedDate
FROM kn_dbair a
LEFT JOIN kn_obl o ON a.OBL = o.ID_OBL;
GO

-- 3. Представление для железнодорожных объектов
CREATE VIEW vw_Railway_Detailed
AS
SELECT
r.ID_RW,
r.NAMERUS AS NameRu,
r.NAMEBEL AS NameBe,
c.NKOD AS Category,
o.OBL AS Region,
r.GEOPR AS Location,
r.X_WGS AS Longitude,
r.Y_WGS AS Latitude,
r.NOMENKLAT,
r.ECP,
r.EXISTENCE AS Status,
r.CreatedDate
FROM kn_dbrw r
LEFT JOIN kn_category c ON r.CATEGORY = c.ID_CATEGOR
LEFT JOIN kn_obl o ON r.OBL = o.ID_OBL;
GO

-- 4. Представление для физико-географических объектов
CREATE VIEW vw_PhysicalGeo_Detailed
AS
SELECT
f.ID_FGO,
f.NAMERUS AS NameRu,
f.NAMEBEL AS NameBe,
rf.RFGONAME AS ObjectType,
o.OBL AS Region,
f.GEOPR AS Description,
f.X_WGS AS Longitude,
f.Y_WGS AS Latitude,
f.NOMENKLAT,
f.BASRIVER AS Basin,
f.PRITOK AS Tributary,
f.FALL,
f.DISTANCE,
f.AREA,
f.DEPTH,
f.EXISTENCE AS Status,
f.CreatedDate
FROM kn_dbfgo f
LEFT JOIN kn_rodfgo rf ON f.RODFGO = rf.ID_RODFGO
LEFT JOIN kn_obl o ON f.OBL = o.ID_OBL;
GO

PRINT 'Представления созданы.';
GO

-- =============================================
-- СОЗДАНИЕ ХРАНИМЫХ ПРОЦЕДУР
-- =============================================

PRINT 'Создание хранимых процедур...';
GO

-- Удаляем существующую процедуру если она есть
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_SearchGeographicObjects')
DROP PROCEDURE sp_SearchGeographicObjects;
GO

-- Создаем новую, исправленную процедуру
CREATE PROCEDURE sp_SearchGeographicObjects
@SearchTerm NVARCHAR(255) = NULL,
@ObjectType NVARCHAR(10) = NULL,
@FirstLetter NVARCHAR(1) = NULL,
@RegionId INT = NULL,
@DistrictId INT = NULL,
@StatusId INT = NULL,
@MinPopulation INT = NULL,
@MaxPopulation INT = NULL,
@MinElevation INT = NULL,
@MaxElevation INT = NULL,
@FoundationYearFrom INT = NULL,
@FoundationYearTo INT = NULL,
@SortBy NVARCHAR(50) = 'name_asc',
@PageNumber INT = 1,
@PageSize INT = 50
AS
BEGIN
SET NOCOUNT ON;

-- Создаем временную таблицу для результатов
CREATE TABLE #SearchResults (
    ObjectType NVARCHAR(10),
    ObjectId INT,
    NameRu NVARCHAR(255),
    NameBe NVARCHAR(255),
    TypeName NVARCHAR(100),
    RegionName NVARCHAR(100),
    DistrictName NVARCHAR(100),
    Longitude FLOAT,
    Latitude FLOAT,
    Population INT,
    Elevation INT,
    FoundationYear INT,
    PostalCode NVARCHAR(20),
    Nomenklat NVARCHAR(50),
    StatusName NVARCHAR(50),
    CreatedDate DATETIME
);

-- 1. НАСЕЛЕННЫЕ ПУНКТЫ (ATE)
IF @ObjectType IS NULL OR @ObjectType = 'ATE'
BEGIN
    INSERT INTO #SearchResults (
        ObjectType, ObjectId, NameRu, NameBe, TypeName, RegionName, DistrictName,
        Longitude, Latitude, Population, Elevation, FoundationYear, PostalCode,
        Nomenklat, StatusName, CreatedDate
    )
    SELECT 
        'ATE',
        b.KOD_ATE,
        b.NAMERUS,
        b.NAMEBEL,
        ISNULL(rt.RATENAME, ''),
        ISNULL(o.OBL, ''),
        ISNULL(r.RA, ''),
        b.X_WGS,
        b.Y_WGS,
        b.Population,
        b.Elevation,
        b.FoundationYear,
        b.PostalCode,
        b.NOMENKLAT,
        ISNULL(b.EXISTENCE, ''),
        ISNULL(b.CreatedDate, GETDATE())
    FROM kn_dbate b
    LEFT JOIN kn_obl o ON b.ID_OBL = o.ID_OBL
    LEFT JOIN kn_ra r ON b.ID_RA = r.ID_RA
    LEFT JOIN kn_rodate rt ON b.ID_RODATE = rt.ID_RODATE
    WHERE 1=1
    AND (b.EXISTENCE = N'существует' OR b.EXISTENCE IS NULL)
    AND (@SearchTerm IS NULL OR b.NAMERUS LIKE '%' + @SearchTerm + '%' OR b.NAMEBEL LIKE '%' + @SearchTerm + '%')
    AND (@FirstLetter IS NULL OR @FirstLetter = '' OR LEFT(b.NAMERUS, 1) = @FirstLetter)
    AND (@RegionId IS NULL OR b.ID_OBL = @RegionId)
    AND (@DistrictId IS NULL OR b.ID_RA = @DistrictId)
    AND (@MinPopulation IS NULL OR b.Population >= @MinPopulation OR b.Population IS NULL)
    AND (@MaxPopulation IS NULL OR b.Population <= @MaxPopulation OR b.Population IS NULL)
    AND (@MinElevation IS NULL OR b.Elevation >= @MinElevation OR b.Elevation IS NULL)
    AND (@MaxElevation IS NULL OR b.Elevation <= @MaxElevation OR b.Elevation IS NULL)
    AND (@FoundationYearFrom IS NULL OR b.FoundationYear >= @FoundationYearFrom OR b.FoundationYear IS NULL)
    AND (@FoundationYearTo IS NULL OR b.FoundationYear <= @FoundationYearTo OR b.FoundationYear IS NULL);
END

-- 2. АЭРОПОРТЫ (AIR)
IF @ObjectType IS NULL OR @ObjectType = 'AIR'
BEGIN
    INSERT INTO #SearchResults (
        ObjectType, ObjectId, NameRu, NameBe, TypeName, RegionName, DistrictName,
        Longitude, Latitude, Population, Elevation, FoundationYear, PostalCode,
        Nomenklat, StatusName, CreatedDate
    )
    SELECT 
        'AIR',
        a.ID_AIR,
        a.NAMERUS,
        a.NAMEBEL,
        ISNULL(a.CATEGORY, ''),
        ISNULL(o.OBL, ''),
        NULL,
        a.X_WGS,
        a.Y_WGS,
        NULL,
        a.ElevationFeet,
        NULL,
        NULL,
        a.NOMENKLAT,
        'Действующий',
        ISNULL(a.CreatedDate, GETDATE())
    FROM kn_dbair a
    LEFT JOIN kn_obl o ON a.OBL = o.ID_OBL
    WHERE 1=1
    AND (@SearchTerm IS NULL OR a.NAMERUS LIKE '%' + @SearchTerm + '%' OR a.NAMEBEL LIKE '%' + @SearchTerm + '%')
    AND (@FirstLetter IS NULL OR @FirstLetter = '' OR LEFT(a.NAMERUS, 1) = @FirstLetter)
    AND (@RegionId IS NULL OR a.OBL = @RegionId);
END

-- 3. ЖЕЛЕЗНОДОРОЖНЫЕ ОБЪЕКТЫ (RW)
IF @ObjectType IS NULL OR @ObjectType = 'RW'
BEGIN
    INSERT INTO #SearchResults (
        ObjectType, ObjectId, NameRu, NameBe, TypeName, RegionName, DistrictName,
        Longitude, Latitude, Population, Elevation, FoundationYear, PostalCode,
        Nomenklat, StatusName, CreatedDate
    )
    SELECT 
        'RW',
        r.ID_RW,
        r.NAMERUS,
        r.NAMEBEL,
        ISNULL(c.NKOD, ''),
        ISNULL(o.OBL, ''),
        NULL,
        r.X_WGS,
        r.Y_WGS,
        NULL,
        r.Elevation,
        NULL,
        NULL,
        r.NOMENKLAT,
        ISNULL(r.EXISTENCE, ''),
        ISNULL(r.CreatedDate, GETDATE())
    FROM kn_dbrw r
    LEFT JOIN kn_obl o ON r.OBL = o.ID_OBL
    LEFT JOIN kn_category c ON r.CATEGORY = c.ID_CATEGOR
    WHERE 1=1
    AND (r.EXISTENCE = N'существует' OR r.EXISTENCE IS NULL)
    AND (@SearchTerm IS NULL OR r.NAMERUS LIKE '%' + @SearchTerm + '%' OR r.NAMEBEL LIKE '%' + @SearchTerm + '%')
    AND (@FirstLetter IS NULL OR @FirstLetter = '' OR LEFT(r.NAMERUS, 1) = @FirstLetter)
    AND (@RegionId IS NULL OR r.OBL = @RegionId);
END

-- 4. ФИЗИКО-ГЕОГРАФИЧЕСКИЕ ОБЪЕКТЫ (FGO)
IF @ObjectType IS NULL OR @ObjectType = 'FGO'
BEGIN
    INSERT INTO #SearchResults (
        ObjectType, ObjectId, NameRu, NameBe, TypeName, RegionName, DistrictName,
        Longitude, Latitude, Population, Elevation, FoundationYear, PostalCode,
        Nomenklat, StatusName, CreatedDate
    )
    SELECT 
        'FGO',
        f.ID_FGO,
        f.NAMERUS,
        f.NAMEBEL,
        ISNULL(rf.RFGONAME, ''),
        ISNULL(o.OBL, ''),
        NULL,
        f.X_WGS,
        f.Y_WGS,
        NULL,
        f.MaxElevation,
        NULL,
        NULL,
        f.NOMENKLAT,
        ISNULL(f.EXISTENCE, ''),
        ISNULL(f.CreatedDate, GETDATE())
    FROM kn_dbfgo f
    LEFT JOIN kn_obl o ON f.OBL = o.ID_OBL
    LEFT JOIN kn_rodfgo rf ON f.RODFGO = rf.ID_RODFGO
    WHERE 1=1
    AND (f.EXISTENCE = N'существует' OR f.EXISTENCE IS NULL)
    AND (@SearchTerm IS NULL OR f.NAMERUS LIKE '%' + @SearchTerm + '%' OR f.NAMEBEL LIKE '%' + @SearchTerm + '%')
    AND (@FirstLetter IS NULL OR @FirstLetter = '' OR LEFT(f.NAMERUS, 1) = @FirstLetter)
    AND (@RegionId IS NULL OR f.OBL = @RegionId);
END

-- Получаем общее количество
DECLARE @TotalCount INT = (SELECT COUNT(*) FROM #SearchResults);

-- Определяем порядок сортировки
DECLARE @OrderByClause NVARCHAR(500);
SET @OrderByClause = CASE @SortBy
    WHEN 'name_desc' THEN 'ORDER BY NameRu DESC'
    WHEN 'population_desc' THEN 'ORDER BY Population DESC NULLS LAST, NameRu'
    WHEN 'elevation_desc' THEN 'ORDER BY Elevation DESC NULLS LAST, NameRu'
    WHEN 'date_desc' THEN 'ORDER BY CreatedDate DESC, NameRu'
    WHEN 'relevance' THEN 'ORDER BY 
        CASE ObjectType WHEN ''ATE'' THEN 1 WHEN ''AIR'' THEN 2 WHEN ''RW'' THEN 3 WHEN ''FGO'' THEN 4 ELSE 5 END,
        NameRu'
    ELSE 'ORDER BY NameRu ASC'
END;

-- Возвращаем результаты с пагинацией
DECLARE @SqlQuery NVARCHAR(MAX);
SET @SqlQuery = '
    WITH OrderedResults AS (
        SELECT 
            *,
            ROW_NUMBER() OVER (' + @OrderByClause + ') AS RowNum,
            ' + CAST(@TotalCount AS NVARCHAR) + ' AS TotalCount
        FROM #SearchResults
    )
    SELECT 
        ObjectType,
        ObjectId,
        NameRu,
        NameBe,
        TypeName,
        RegionName,
        DistrictName,
        Longitude,
        Latitude,
        Population,
        Elevation,
        FoundationYear,
        PostalCode,
        Nomenklat,
        StatusName,
        CreatedDate,
        RowNum,
        TotalCount
    FROM OrderedResults
    WHERE RowNum BETWEEN ' + CAST(((@PageNumber - 1) * @PageSize + 1) AS NVARCHAR) + 
                   ' AND ' + CAST((@PageNumber * @PageSize) AS NVARCHAR);

EXEC sp_executesql @SqlQuery;

-- Удаляем временную таблицу
DROP TABLE #SearchResults;

END
GO

PRINT 'Процедура sp_SearchGeographicObjects создана успешно!';
GO

-- 1. Процедура поиска объектов по названию
CREATE PROCEDURE sp_SearchObjectByName
@SearchTerm NVARCHAR(255)
AS
BEGIN
SET NOCOUNT ON;

DECLARE @SearchPattern NVARCHAR(257) = '%' + @SearchTerm + '%';

-- Поиск населенных пунктов
SELECT 
    'Населенный пункт' AS ObjectType,
    b.KOD_ATE AS ObjectID,
    b.NAMERUS AS NameRu,
    b.NAMEBEL AS NameBe,
    b.NOMENKLAT,
    b.X_WGS AS Longitude,
    b.Y_WGS AS Latitude,
    o.OBL AS Region,
    r.RA AS District
FROM kn_dbate b
LEFT JOIN kn_obl o ON b.ID_OBL = o.ID_OBL
LEFT JOIN kn_ra r ON b.ID_RA = r.ID_RA
WHERE (b.NAMERUS LIKE @SearchPattern OR b.NAMEBEL LIKE @SearchPattern)
    AND b.EXISTENCE = N'существует'

UNION ALL

-- Поиск аэропортов
SELECT 
    'Аэропорт' AS ObjectType,
    a.ID_AIR AS ObjectID,
    a.NAMERUS AS NameRu,
    a.NAMEBEL AS NameBe,
    a.NOMENKLAT,
    a.X_WGS AS Longitude,
    a.Y_WGS AS Latitude,
    o.OBL AS Region,
    NULL AS District
FROM kn_dbair a
LEFT JOIN kn_obl o ON a.OBL = o.ID_OBL
WHERE (a.NAMERUS LIKE @SearchPattern OR a.NAMEBEL LIKE @SearchPattern)

UNION ALL

-- Поиск железнодорожных объектов
SELECT 
    'Железнодорожный объект' AS ObjectType,
    rw.ID_RW AS ObjectID,
    rw.NAMERUS AS NameRu,
    rw.NAMEBEL AS NameBe,
    rw.NOMENKLAT,
    rw.X_WGS AS Longitude,
    rw.Y_WGS AS Latitude,
    o.OBL AS Region,
    NULL AS District
FROM kn_dbrw rw
LEFT JOIN kn_obl o ON rw.OBL = o.ID_OBL
WHERE (rw.NAMERUS LIKE @SearchPattern OR rw.NAMEBEL LIKE @SearchPattern)
    AND rw.EXISTENCE = N'существует'

UNION ALL

-- Поиск физико-географических объектов
SELECT 
    'Физико-географический объект' AS ObjectType,
    f.ID_FGO AS ObjectID,
    f.NAMERUS AS NameRu,
    f.NAMEBEL AS NameBe,
    f.NOMENKLAT,
    f.X_WGS AS Longitude,
    f.Y_WGS AS Latitude,
    o.OBL AS Region,
    NULL AS District
FROM kn_dbfgo f
LEFT JOIN kn_obl o ON f.OBL = o.ID_OBL
WHERE (f.NAMERUS LIKE @SearchPattern OR f.NAMEBEL LIKE @SearchPattern)
    AND f.EXISTENCE = N'существует';

END
GO

-- 2. Процедура получения статистики по регионам
CREATE PROCEDURE sp_GetRegionStatistics
AS
BEGIN
SET NOCOUNT ON;

SELECT 
    o.ID_OBL AS RegionID,
    o.OBL AS RegionName,
    COUNT(DISTINCT r.ID_RA) AS DistrictsCount,
    COUNT(DISTINCT b.KOD_ATE) AS SettlementsCount,
    COUNT(DISTINCT a.ID_AIR) AS AirportsCount,
    COUNT(DISTINCT rw.ID_RW) AS RailwayObjectsCount,
    COUNT(DISTINCT f.ID_FGO) AS PhysicalGeoObjectsCount,
    SUM(CASE WHEN b.EXISTENCE = N'существует' THEN 1 ELSE 0 END) AS ActiveSettlements
FROM kn_obl o
LEFT JOIN kn_ra r ON o.ID_OBL = r.ID_OBL
LEFT JOIN kn_dbate b ON o.ID_OBL = b.ID_OBL
LEFT JOIN kn_dbair a ON o.ID_OBL = a.OBL
LEFT JOIN kn_dbrw rw ON o.ID_OBL = rw.OBL
LEFT JOIN kn_dbfgo f ON o.ID_OBL = f.OBL
GROUP BY o.ID_OBL, o.OBL
ORDER BY o.ID_OBL;

END
GO

PRINT 'Хранимые процедуры созданы.';
GO

-- =============================================
-- ФИНАЛЬНАЯ ПРОВЕРКА
-- =============================================

PRINT 'Проверка целостности данных...';
GO

-- Проверка целостности внешних ключей
PRINT 'Проверка внешних ключей...';
SELECT
OBJECT_NAME(fk.parent_object_id) AS TableName,
fk.name AS ForeignKeyName,
CASE
WHEN fk.is_not_trusted = 1 THEN 'Не проверен (WITH NOCHECK)'
ELSE 'Проверен'
END AS Status
FROM sys.foreign_keys fk
ORDER BY TableName;
GO