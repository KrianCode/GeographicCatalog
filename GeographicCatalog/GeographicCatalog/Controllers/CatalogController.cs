// GeographicCatalog/Controllers/CatalogController.cs
using Dapper;
using GeographicCatalog.Models;
using iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Data;
using System.Globalization;
using Npgsql;
using System.Text;

namespace GeographicCatalog.Controllers
{
    public class CatalogController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<CatalogController> _logger;
        private readonly int _pageSize = 50;
        private readonly IWebHostEnvironment _hostingEnvironment;
        // --- ВАЖНО: Кириллическая Е в имени колонки daterЕg для kn_dbate ---
        private const string AteDateColumn = "daterЕg";

        public CatalogController(IConfiguration configuration, ILogger<CatalogController> logger, IWebHostEnvironment hostingEnvironment)
        {
            _configuration = configuration;
            _logger = logger;
            _hostingEnvironment = hostingEnvironment;
        }

        [HttpGet]
        public IActionResult Index(
            string searchQuery = null,
            string objectType = null,
            string firstLetter = null,
            int? regionId = null,
            int? districtId = null,
            int? statusId = null,
            int? minPopulation = null,
            int? maxPopulation = null,
            int? minElevation = null,
            int? maxElevation = null,
            int? foundationYearFrom = null,
            int? foundationYearTo = null,
            string sortBy = null,
            int page = 1)
        {
            try
            {
                var model = new SearchModel
                {
                    SearchQuery = searchQuery,
                    ObjectType = objectType,
                    FirstLetter = firstLetter,
                    RegionId = regionId,
                    DistrictId = districtId,
                    StatusId = statusId,
                    MinPopulation = minPopulation,
                    MaxPopulation = maxPopulation,
                    MinElevation = minElevation,
                    MaxElevation = maxElevation,
                    FoundationYearFrom = foundationYearFrom,
                    FoundationYearTo = foundationYearTo,
                    SortBy = sortBy,
                    Page = page,
                    PageSize = _pageSize
                };
                GenerateAlphabet(model);
                LoadFilterData();
                
                ViewBag.FilterVisibility = new
                {
                    population = new[] { "ATE" },
                    elevation = new[] { "FGO" }
                };
                
                _logger?.LogInformation("Поиск с параметрами: SearchQuery={SearchQuery}, ObjectType={ObjectType}, RegionId={RegionId}, Page={Page}",
                    searchQuery, objectType, regionId, page);
                
                SearchObjects(model);
                ViewBag.Statistics = GetCatalogStatistics();
                ViewBag.CurrentObjectType = objectType;
                ViewBag.HasResults = model.Results?.Count > 0;
                
                return View(model);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка в действии Index");
                TempData["ErrorMessage"] = $"Ошибка: {ex.Message}";
                return View(new SearchModel());
            }
        }

        [HttpPost]
        public IActionResult Search(SearchModel model)
        {
            if (model == null)
                return RedirectToAction("Index");
            return RedirectToAction("Index", new
            {
                searchQuery = model.SearchQuery,
                objectType = model.ObjectType,
                firstLetter = model.FirstLetter,
                regionId = model.RegionId,
                districtId = model.DistrictId,
                statusId = model.StatusId,
                minPopulation = model.MinPopulation,
                maxPopulation = model.MaxPopulation,
                minElevation = model.MinElevation,
                maxElevation = model.MaxElevation,
                foundationYearFrom = model.FoundationYearFrom,
                foundationYearTo = model.FoundationYearTo,
                sortBy = model.SortBy,
                page = 1
            });
        }

        [HttpGet]
        public IActionResult GetFilteredData(
            [FromQuery, Bind(Prefix = "")] SearchModel model,
            int? regionId = null,
            int? districtId = null)
        {
            if (model == null) model = new SearchModel();
            model.PageSize = _pageSize;
            MergeGeoFiltersFromRequestQuery(model, Request);
            if (regionId.HasValue && regionId.Value > 0)
                model.RegionId = regionId.Value;
            if (districtId.HasValue && districtId.Value > 0)
                model.DistrictId = districtId.Value;

            SearchObjects(model);
            return PartialView("_SearchResultsPartial", model);
        }

        [HttpGet]
        public IActionResult TestSearch()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                var testResults = new List<dynamic>();
                
                var ateCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbate WHERE existence = 'существует'");
                testResults.Add(new { Test = "Населенные пункты (ATE)", Count = ateCount });
                
                var airCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbair");
                testResults.Add(new { Test = "Аэропорты (AIR)", Count = airCount });
                
                var rwCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbrw WHERE existence = 'существует'");
                testResults.Add(new { Test = "Ж/д объекты (RW)", Count = rwCount });
                
                var fgoCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbfgo WHERE existence = 'существует'");
                testResults.Add(new { Test = "ФГО (FGO)", Count = fgoCount });
                
                var simpleAte = connection.Query(@"
                    SELECT
                    b.""kod_ate"" as ObjectId,
                    b.namerus as NameRu,
                    b.namebel as NameBe,
                    o.obl as RegionName
                    FROM kn_dbate b
                    LEFT JOIN kn_obl o ON b.id_obl = o.id_obl
                    WHERE b.existence = 'существует'
                    ORDER BY b.namerus
                    LIMIT 5").ToList();
                
                return Json(new
                {
                    success = true,
                    tests = testResults,
                    simpleAte = simpleAte,
                    connectionString = _configuration.GetConnectionString("DefaultConnection")
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    error = ex.Message,
                    connectionString = _configuration.GetConnectionString("DefaultConnection")
                });
            }
        }

[Route("Catalog/ATE/{id:int}")]
public IActionResult DetailsATE(int id)
{
    try
    {
        using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        
        // --- ИСПРАВЛЕНО: soato::numeric, daterЕg::timestamp с обработкой NULL ---
        var ate = connection.QueryFirstOrDefault<AdministrativeUnit>(
            @"SELECT
                b.""kod_ate"" as ID,
                b.namerus as NAMERUS,
                b.namebel as NAMEBEL,
                b.namelat as NAMELAT,
                b.nomenklat as NOMENKLAT,
                b.soato::numeric as SOATO,
                b.sovet as SOVET,
                b.udarrus as UDARRUS,
                b.udarbel as UDARBEL,
                b.x_wgs as Latitude,
                b.y_wgs as Longitude,
                b.""daterЕg""::timestamp as DATEREG,
                CASE 
                    WHEN b.""daterЕg"" IS NOT NULL 
                    THEN EXTRACT(YEAR FROM b.""daterЕg""::timestamp)::int 
                    ELSE NULL 
                END as FoundationYear,
                b.existence as EXISTENCE,
                o.obl as RegionName,
                r.ra as DistrictName,
                rt.ratename as CategoryName,
                b.sinforus as SINFORUS,
                b.sinfobel as SINFOBEL
            FROM kn_dbate b
            LEFT JOIN kn_obl o ON b.id_obl = o.id_obl
            LEFT JOIN kn_ra r ON b.id_ra = r.id_ra
            LEFT JOIN kn_rodate rt ON b.id_rodate = rt.id_rodate
            WHERE b.""kod_ate"" = @Id",
            new { Id = id });
        
        if (ate == null)
        {
            TempData["ErrorMessage"] = "Населенный пункт не найден";
            return RedirectToAction("Index");
        }
        
        // Последняя информация о населении
        var latestPopulation = connection.QueryFirstOrDefault(
            @"SELECT popular as Population, EXTRACT(YEAR FROM datacensus::timestamp)::int as PopulationYear
            FROM kn_hpopular
            WHERE kod_ate = @KodAte
            ORDER BY datacensus DESC
            LIMIT 1",
            new { KodAte = ate.ID });
        
        if (latestPopulation != null)
        {
            ate.Population = ToIntNull(latestPopulation.Population);
            ate.PopulationYear = ToIntNull(latestPopulation.PopulationYear);
        }
        
        // Исторические названия
        var historicalNames = connection.Query<string>(
            @"SELECT drtnamerus FROM kn_atedrnamerus WHERE kod_ate = @KodAte
            UNION
            SELECT drtnamebel FROM kn_atedrnamebel WHERE kod_ate = @KodAte",
            new { KodAte = ate.ID }).Distinct().ToList();
        
        // Динамика населения
        var populationHistory = connection.Query(
            @"SELECT datacensus as CensusDate, popular as Population
            FROM kn_hpopular
            WHERE kod_ate = @KodAte
            ORDER BY datacensus DESC",
            new { KodAte = ate.ID }).ToList();
        
        // История изменений
        var changeHistory = connection.Query(
            @"SELECT redate as ChangeDate, changes as ChangeDescription, namedoc as DocumentName, datedoc as DocumentDate
            FROM kn_hchangeate
            WHERE kod_ate = @KodAte
            ORDER BY redate DESC",
            new { KodAte = ate.ID }).ToList();
        
        ViewBag.HistoricalNames = historicalNames;
        ViewBag.PopulationHistory = populationHistory;
        ViewBag.ChangeHistory = changeHistory;
        ViewBag.PageTitle = $"{ate.NAMERUS} - Детальная информация";
        
        return View("DetailsATE", ate);
    }
    catch (Exception ex)
    {
        _logger?.LogError(ex, "Ошибка при получении детальной информации для АТЕ с ID {Id}", id);
        TempData["ErrorMessage"] = $"Ошибка при получении данных: {ex.Message}";
        return RedirectToAction("Index");
    }
}

        [Route("Catalog/Airport/{id:int}")]
        public IActionResult DetailsAirport(int id)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                
                // --- ИСПРАВЛЕНО: datereg::timestamp ---
                var airport = connection.QueryFirstOrDefault<Airport>(
                    @"SELECT
                        a.id_air as ID_AIR,
                        a.namerus as NAMERUS,
                        a.namebel as NAMEBEL,
                        a.namelat as NAMELAT,
                        a.category as CATEGORY,
                        a.nomenklat as NOMENKLAT,
                        a.x_wgs as Latitude,
                        a.y_wgs as Longitude,
                        a.datereg::timestamp as DATEREG,
                        a.geopr as LocationDescription,
                        a.udarrus as UDARRUS,
                        a.udarbel as UDARBEL,
                        o.obl as RegionName,
                        r.ra as DistrictName
                    FROM kn_dbair a
                    LEFT JOIN kn_obl o ON a.obl = o.id_obl
                    LEFT JOIN kn_ra r ON a.ra = r.id_ra
                    WHERE a.id_air = @Id",
                    new { Id = id });
                
                if (airport == null)
                {
                    TempData["ErrorMessage"] = "Аэропорт не найден";
                    return RedirectToAction("Index");
                }
                
                var changeHistory = connection.Query(
                    @"SELECT redate as ChangeDate, changes as ChangeDescription, namedoc as DocumentName, datedoc as DocumentDate
                    FROM kn_hchangeair
                    WHERE id_air = @Id
                    ORDER BY redate DESC",
                    new { Id = id }).ToList();
                
                ViewBag.ChangeHistory = changeHistory;
                ViewBag.PageTitle = $"{airport.NAMERUS} - Детальная информация";
                
                return View("DetailsAirport", airport);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении детальной информации для аэропорта с ID {Id}", id);
                TempData["ErrorMessage"] = $"Ошибка при получении данных: {ex.Message}";
                return RedirectToAction("Index");
            }
        }

        [Route("Catalog/Railway/{id:int}")]
        public IActionResult DetailsRailway(int id)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                
                // --- ИСПРАВЛЕНО: datereg::timestamp, id_rw в кавычках ---
                var railway = connection.QueryFirstOrDefault<RailwayObject>(
                    @"SELECT
                        r.""id_rw"" as ID_RW,
                        r.namerus as NAMERUS,
                        r.namebel as NAMEBEL,
                        r.namelat as NAMELAT,
                        r.namenorm as NAMENORM,
                        r.ecp as ECP,
                        r.nomenklat as NOMENKLAT,
                        r.x_wgs as Latitude,
                        r.y_wgs as Longitude,
                        r.datereg::timestamp as DATEREG,
                        r.existence as EXISTENCE,
                        r.geopr as LocationDescription,
                        r.udarrus as UDARRUS,
                        r.udarbel as UDARBEL,
                        o.obl as RegionName,
                        ra.ra as DistrictName,
                        c.nkod as CategoryName,
                        n.nod as NodeName
                    FROM kn_dbrw r
                    LEFT JOIN kn_obl o ON r.obl = o.id_obl
                    LEFT JOIN kn_ra ra ON r.ra = ra.id_ra
                    LEFT JOIN kn_category c ON r.category = c.id_categor
                    LEFT JOIN kn_nod n ON r.nods = n.id_nod
                    WHERE r.""id_rw"" = @Id",
                    new { Id = id });
                
                if (railway == null)
                {
                    TempData["ErrorMessage"] = "Железнодорожный объект не найден";
                    return RedirectToAction("Index");
                }
                
                var changeHistory = connection.Query(
                    @"SELECT redate as ChangeDate, changes as ChangeDescription, namedoc as DocumentName, datedoc as DocumentDate
                    FROM kn_hchangerw
                    WHERE id_rw = @Id
                    ORDER BY redate DESC",
                    new { Id = id }).ToList();
                
                ViewBag.ChangeHistory = changeHistory;
                ViewBag.PageTitle = $"{railway.NAMERUS} - Детальная информация";
                
                return View("DetailsRailway", railway);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении детальной информации для ж/д объекта с ID {Id}", id);
                TempData["ErrorMessage"] = $"Ошибка при получении данных: {ex.Message}";
                return RedirectToAction("Index");
            }
        }

        [Route("Catalog/FGO/{id:int}")]
        public IActionResult DetailsPhysicalGeo(int id)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                
                // --- ИСПРАВЛЕНО: datereg::timestamp ---
                var fgo = connection.QueryFirstOrDefault<PhysicalGeoObject>(
                    @"SELECT
                        f.id_fgo as ID_FGO,
                        f.namerus as NAMERUS,
                        f.namebel as NAMEBEL,
                        f.namelat as NAMELAT,
                        f.nomenklat as NOMENKLAT,
                        f.x_wgs as Latitude,
                        f.y_wgs as Longitude,
                        f.datereg::timestamp as DATEREG,
                        f.existence as EXISTENCE,
                        f.geopr as Description,
                        f.basriver as Basin,
                        f.pritok as Tributary,
                        f.fall as FALL,
                        f.distance as DISTANCE,
                        f.area as AREA,
                        f.depth as DEPTH,
                        f.sudohod as Navigable,
                        f.specnotes as SpecialNotes,
                        f.udarrus as UDARRUS,
                        f.udarbel as UDARBEL,
                        o.obl as RegionName,
                        rf.rfgoname as TypeName,
                        f.sinforus as SINFORUS,
                        f.sinfobel as SINFOBEL
                    FROM kn_dbfgo f
                    LEFT JOIN kn_obl o ON f.obl = o.id_obl
                    LEFT JOIN kn_rodfgo rf ON f.rodfgo = rf.id_rodfgo
                    WHERE f.id_fgo = @Id",
                    new { Id = id });
                
                if (fgo == null)
                {
                    TempData["ErrorMessage"] = "Физико-географический объект не найден";
                    return RedirectToAction("Index");
                }
                
                var alternativeNames = connection.Query<string>(
                    @"SELECT drtnamerus FROM kn_fgodrtnamerus WHERE id_fgo = @Id
                    UNION
                    SELECT drtnamebel FROM kn_fgodrtnamebel WHERE id_fgo = @Id",
                    new { Id = id }).Distinct().ToList();
                
                var districts = connection.Query<string>(
                    @"SELECT r.ra as DistrictName
                    FROM kn_dbfgo_obl_ra dor
                    JOIN kn_ra r ON dor.ra = r.id_ra
                    WHERE dor.fgo_id = @Id",
                    new { Id = id }).ToList();
                
                var changeHistory = connection.Query(
                    @"SELECT redate as ChangeDate, changes as ChangeDescription, namedoc as DocumentName, datedoc as DocumentDate
                    FROM kn_hchangefgo
                    WHERE id_fgo = @Id
                    ORDER BY redate DESC",
                    new { Id = id }).ToList();
                
                ViewBag.AlternativeNames = alternativeNames;
                ViewBag.Districts = districts;
                ViewBag.ChangeHistory = changeHistory;
                ViewBag.PageTitle = $"{fgo.NAMERUS} - Детальная информация";
                
                return View("DetailsPhysicalGeo", fgo);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении детальной информации для ФГО с ID {Id}", id);
                TempData["ErrorMessage"] = $"Ошибка при получении данных: {ex.Message}";
                return RedirectToAction("Index");
            }
        }

        [HttpGet]
        public IActionResult Details(string type, int id)
        {
            return type?.ToUpper() switch
            {
                "ATE" => RedirectToAction("DetailsATE", new { id }),
                "AIR" => RedirectToAction("DetailsAirport", new { id }),
                "RW" => RedirectToAction("DetailsRailway", new { id }),
                "FGO" => RedirectToAction("DetailsPhysicalGeo", new { id }),
                _ => RedirectToAction("Index")
            };
        }

        [HttpGet]
        public IActionResult GetObjectCoordinates(string type, int id)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                dynamic result = null;
                var query = "";
                
                switch (type.ToUpper())
                {
                    case "ATE":
                        query = $@"SELECT b.x_wgs as Latitude, b.y_wgs as Longitude, b.namerus as Name
                            FROM kn_dbate b WHERE b.""kod_ate"" = @Id";
                        result = connection.QueryFirstOrDefault(query, new { Id = id });
                        break;
                    case "AIR":
                        query = @"SELECT a.x_wgs as Latitude, a.y_wgs as Longitude, a.namerus as Name
                            FROM kn_dbair a WHERE a.id_air = @Id";
                        result = connection.QueryFirstOrDefault(query, new { Id = id });
                        break;
                    case "RW":
                        query = $@"SELECT r.x_wgs as Latitude, r.y_wgs as Longitude, r.namerus as Name
                            FROM kn_dbrw r WHERE r.""id_rw"" = @Id";
                        result = connection.QueryFirstOrDefault(query, new { Id = id });
                        break;
                    case "FGO":
                        query = @"SELECT f.x_wgs as Latitude, f.y_wgs as Longitude, f.namerus as Name
                            FROM kn_dbfgo f WHERE f.id_fgo = @Id";
                        result = connection.QueryFirstOrDefault(query, new { Id = id });
                        break;
                }
                
                if (result != null)
                {
                    return Json(new
                    {
                        success = true,
                        latitude = result.Latitude,
                        longitude = result.Longitude,
                        name = result.Name,
                        type = type
                    });
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении координат для объекта типа {Type} с ID {Id}", type, id);
                return Json(new { success = false, error = ex.Message });
            }
            return Json(new { success = false, error = "Объект не найден" });
        }

        [HttpGet]
        public IActionResult ExportToCsv([FromQuery] SearchModel model)
        {
            try
            {
                if (model == null) model = new SearchModel();
                SearchObjects(model, false);
                
                var sb = new StringBuilder();
                var preamble = Encoding.UTF8.GetPreamble();
                var csvBytes = new List<byte>(preamble);
                
                sb.AppendLine("Тип;ID;Название (рус.);Название (бел.);Тип объекта;Область;Район;Координаты;Население;Высота;Статус;Год основания;Почтовый индекс;Номенклатура");
                
                var objectTypes = new Dictionary<string, string>
                {
                    { "ATE", "Населенный пункт" },
                    { "AIR", "Аэропорт" },
                    { "RW", "Железнодорожный объект" },
                    { "FGO", "Физ.-гео. объект" }
                };
                
                foreach (var item in model.Results)
                {
                    var objectTypeName = objectTypes.ContainsKey(item.ObjectType)
                        ? objectTypes[item.ObjectType]
                        : item.ObjectType;
                    
                    sb.AppendLine(
                        $"{EscapeCsvField(objectTypeName)};" +
                        $"{item.ObjectId};" +
                        $"{EscapeCsvField(item.NameRu)};" +
                        $"{EscapeCsvField(item.NameBe)};" +
                        $"{EscapeCsvField(item.TypeName)};" +
                        $"{EscapeCsvField(item.RegionName)};" +
                        $"{EscapeCsvField(item.DistrictName)};" +
                        $"{EscapeCsvField(item.Coordinates)};" +
                        $"{EscapeCsvField(item.Population?.ToString() ?? "Нет данных")};" +
                        $"{EscapeCsvField(item.Elevation?.ToString() ?? "Нет данных")};" +
                        $"{EscapeCsvField(item.StatusName)};" +
                        $"{EscapeCsvField(item.FoundationYear?.ToString() ?? "Нет данных")};" +
                        $"{EscapeCsvField(item.PostalCode ?? "Нет данных")};" +
                        $"{EscapeCsvField(item.Nomenklat)}");
                }
                
                var contentBytes = Encoding.UTF8.GetBytes(sb.ToString());
                csvBytes.AddRange(contentBytes);
                
                return File(csvBytes.ToArray(), "text/csv; charset=utf-8",
                    $"geographic_catalog_{DateTime.Now:yyyyMMdd_HHmmss}.csv");
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при экспорте в CSV");
                TempData["ErrorMessage"] = $"Ошибка при экспорте: {ex.Message}";
                return RedirectToAction("Index");
            }
        }

        private string EscapeCsvField(string field)
        {
            if (string.IsNullOrEmpty(field))
                return "";
            if (field.Contains(";") || field.Contains("\"") || field.Contains("\n") || field.Contains("\r"))
            {
                field = field.Replace("\"", "\"\"");
                return $"\"{field}\"";
            }
            return field;
        }

        [HttpGet]
        public IActionResult GetRegions()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                var regions = QueryRegionsForSelect(connection);
                return Json(regions);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении списка областей");
                return Json(new List<SelectListItem>());
            }
        }

        [HttpGet]
        public IActionResult GetDistrictsByRegion(int regionId)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                var regionName = connection.QuerySingleOrDefault<string>(
                    "SELECT obl FROM kn_obl WHERE id_obl = @RegionId",
                    new { RegionId = regionId });
                if (string.Equals(regionName?.Trim(), "Минск", StringComparison.Ordinal))
                    return Json(new List<SelectListItem>());

                var query = @"
                    WITH AllDistrictIds AS (
                        SELECT id_ra AS DistrictId FROM kn_dbate WHERE id_obl = @RegionId AND id_ra IS NOT NULL
                        UNION
                        SELECT ra AS DistrictId FROM kn_dbair WHERE obl = @RegionId AND ra IS NOT NULL
                        UNION
                        SELECT ra AS DistrictId FROM kn_dbfgo WHERE obl = @RegionId AND ra IS NOT NULL
                        UNION
                        SELECT ra AS DistrictId FROM kn_dbrw WHERE obl = @RegionId AND ra IS NOT NULL
                        UNION
                        SELECT ra AS DistrictId FROM kn_dbfgo_obl_ra WHERE obl = @RegionId AND ra IS NOT NULL
                    )
                    SELECT
                        ra.id_ra AS id_ra,
                        ra.ra AS ra_name
                    FROM kn_ra AS ra
                    INNER JOIN AllDistrictIds AS adi ON ra.id_ra = adi.DistrictId
                    ORDER BY ra.ra";
                
                var districts = connection.Query<(int id_ra, string ra_name)>(query, new { RegionId = regionId })
                    .Select(x => new SelectListItem { Value = x.id_ra.ToString(), Text = x.ra_name ?? "" })
                    .ToList();
                
                _logger?.LogInformation("GetDistrictsByRegion: RegionId={RegionId}, Count={Count}", regionId, districts.Count);
                
                return Json(districts);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении районов для области {RegionId}", regionId);
                return Json(new List<SelectListItem>());
            }
        }

        private bool ShouldPerformSearch(SearchModel model)
        {
            return true;
        }

        /// <summary>
        /// Dapper не всегда корректно заполняет <see cref="SelectListItem"/> из алиасов Value/Text — id в выпадающем списке может оказаться пустым.
        /// </summary>
        private static List<SelectListItem> QueryRegionsForSelect(NpgsqlConnection connection) =>
            connection.Query<(int id_obl, string obl)>("SELECT id_obl, obl FROM kn_obl ORDER BY obl")
                .Select(x => new SelectListItem { Value = x.id_obl.ToString(), Text = x.obl ?? "" })
                .ToList();

        /// <summary>
        /// Области, по которым в справочнике нет привязки к районам (например г. Минск как отдельная область в kn_obl).
        /// Запись с наименованием «Минск» всегда включается: у города нет районного деления в фильтре, даже если в БД есть «лишние» связи.
        /// Совпадает с логикой отбора районов в <see cref="GetDistrictsByRegion"/>.
        /// </summary>
        private static List<int> QueryRegionIdsWithNoDistricts(NpgsqlConnection connection)
        {
            const string sql = @"
                SELECT o.id_obl
                FROM kn_obl o
                WHERE NOT EXISTS (
                    SELECT 1 FROM kn_dbate b WHERE b.id_obl = o.id_obl AND b.id_ra IS NOT NULL
                )
                AND NOT EXISTS (
                    SELECT 1 FROM kn_dbair a WHERE a.obl = o.id_obl AND a.ra IS NOT NULL
                )
                AND NOT EXISTS (
                    SELECT 1 FROM kn_dbfgo f WHERE f.obl = o.id_obl AND f.ra IS NOT NULL
                )
                AND NOT EXISTS (
                    SELECT 1 FROM kn_dbrw w WHERE w.obl = o.id_obl AND w.ra IS NOT NULL
                )
                AND NOT EXISTS (
                    SELECT 1 FROM kn_dbfgo_obl_ra x WHERE x.obl = o.id_obl AND x.ra IS NOT NULL
                )
                OR TRIM(COALESCE(o.obl, '')) = 'Минск'
                ORDER BY o.id_obl";
            return connection.Query<int>(sql).ToList();
        }

        private void LoadFilterData()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                
                ViewBag.Regions = QueryRegionsForSelect(connection);
                ViewBag.RegionIdsWithNoDistricts = QueryRegionIdsWithNoDistricts(connection);
                
                ViewBag.Statuses = new List<SelectListItem>();
                
                ViewBag.SortOptions = new List<SelectListItem>
                {
                    new SelectListItem { Value = "name_asc", Text = "По названию (А-Я)" },
                    new SelectListItem { Value = "name_desc", Text = "По названию (Я-А)" },
                    new SelectListItem { Value = "population_desc", Text = "По населению (убыв.)" },
                    new SelectListItem { Value = "elevation_desc", Text = "По высоте (убыв.)" },
                    new SelectListItem { Value = "date_desc", Text = "По дате создания (новые)" },
                    new SelectListItem { Value = "relevance", Text = "По релевантности" }
                };
                
                ViewBag.ObjectTypesList = new List<SelectListItem>
                {
                    new SelectListItem { Value = "", Text = "Все типы" },
                    new SelectListItem { Value = "ATE", Text = "Населенные пункты" },
                    new SelectListItem { Value = "AIR", Text = "Аэропорты" },
                    new SelectListItem { Value = "RW", Text = "Железнодорожные объекты" },
                    new SelectListItem { Value = "FGO", Text = "Физ.-гео. объекты" }
                };
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при загрузке данных для фильтров");
                ViewBag.Regions = new List<SelectListItem>();
                ViewBag.RegionIdsWithNoDistricts = new List<int>();
                ViewBag.Statuses = new List<SelectListItem>();
                ViewBag.SortOptions = new List<SelectListItem>();
                ViewBag.ObjectTypesList = new List<SelectListItem>();
            }
        }

        private enum ReportExistenceSqlMode
        {
            Catalog,
            Any,
            ExistsOnly,
            NotExistsOnly
        }

        private static ReportExistenceSqlMode ResolveReportExistenceMode(CatalogSearchMode searchMode, string? reportExistence)
        {
            if (searchMode == CatalogSearchMode.Catalog)
                return ReportExistenceSqlMode.Catalog;
            if (string.IsNullOrWhiteSpace(reportExistence) || string.Equals(reportExistence, "exists", StringComparison.OrdinalIgnoreCase))
                return ReportExistenceSqlMode.ExistsOnly;
            if (string.Equals(reportExistence, "any", StringComparison.OrdinalIgnoreCase))
                return ReportExistenceSqlMode.Any;
            if (string.Equals(reportExistence, "not_exists", StringComparison.OrdinalIgnoreCase))
                return ReportExistenceSqlMode.NotExistsOnly;
            return ReportExistenceSqlMode.ExistsOnly;
        }

        /// <summary>Русские подписи класса объекта для PDF-отчётов; внутренние коды ATE/AIR/RW/FGO не меняются.</summary>
        private static string ObjectTypeDisplayForReport(string? objectType)
        {
            if (string.IsNullOrWhiteSpace(objectType))
                return "—";
            var key = objectType.Trim();
            return key.ToUpperInvariant() switch
            {
                "ATE" => "Административно-территориальные единицы / населённые пункты",
                "AIR" => "Аэропорты",
                "RW" => "Железнодорожные объекты",
                "FGO" => "Физико-географические объекты",
                _ => key
            };
        }

        private static Dictionary<string, List<string>> ParseReportSubtypeTags(IEnumerable<string> tags)
        {
            var d = new Dictionary<string, List<string>>(StringComparer.OrdinalIgnoreCase);
            if (tags == null) return d;
            foreach (var raw in tags)
            {
                if (string.IsNullOrWhiteSpace(raw)) continue;
                var parts = raw.Split(new[] { "||" }, 2, StringSplitOptions.None);
                if (parts.Length != 2) continue;
                var typ = parts[0].Trim().ToUpperInvariant();
                var name = parts[1].Trim();
                if (typ.Length == 0 || name.Length == 0) continue;
                if (!d.TryGetValue(typ, out var list))
                {
                    list = new List<string>();
                    d[typ] = list;
                }
                var has = false;
                foreach (var x in list)
                {
                    if (string.Equals(x, name, StringComparison.Ordinal)) { has = true; break; }
                }
                if (!has)
                    list.Add(name);
            }
            return d;
        }

        /// <summary>
        /// Как в админке: id области/района из строки (целое или «5.0» из text/cast).
        /// </summary>
        private static bool TryParsePositiveGeoId(string? raw, out int id)
        {
            id = 0;
            if (string.IsNullOrWhiteSpace(raw)) return false;
            raw = raw.Trim();
            if (int.TryParse(raw, NumberStyles.Integer, CultureInfo.InvariantCulture, out id) && id > 0)
                return true;
            if (double.TryParse(raw, NumberStyles.Float, CultureInfo.InvariantCulture, out var d))
            {
                id = (int)Math.Truncate(d);
                return id > 0;
            }
            return false;
        }

        /// <summary>
        /// Подставляет область и район из query string.
        /// Учитывает и «плоские» ключи (RegionId), и префикс имени параметра (model.RegionId), без сброса фильтра при мусорном значении.
        /// </summary>
        private static void MergeGeoFiltersFromRequestQuery(SearchModel model, HttpRequest request)
        {
            ApplyGeoIdFromQueryWithSuffixFallback(request.Query, model, isRegion: true);
            ApplyGeoIdFromQueryWithSuffixFallback(request.Query, model, isRegion: false);
        }

        private static void ApplyGeoIdFromQueryWithSuffixFallback(IQueryCollection query, SearchModel model, bool isRegion)
        {
            var keys = isRegion
                ? new[] { "RegionId", "regionId", "region_id", "model.RegionId", "model.regionId", "criteria.RegionId", "criteria.regionId" }
                : new[] { "DistrictId", "districtId", "district_id", "model.DistrictId", "model.districtId", "criteria.DistrictId", "criteria.districtId" };

            Action<int?> assign = isRegion ? (v => model.RegionId = v) : (v => model.DistrictId = v);

            foreach (var k in keys)
            {
                if (!query.TryGetValue(k, out var vals) || vals.Count == 0)
                    continue;

                var raw = vals[0]?.Trim() ?? "";
                if (string.IsNullOrEmpty(raw))
                {
                    assign(null);
                    return;
                }

                if (TryParsePositiveGeoId(raw, out var n))
                {
                    assign(n);
                    return;
                }
            }

            var dotSuffix = isRegion ? ".RegionId" : ".DistrictId";
            foreach (var kv in query)
            {
                if (kv.Value.Count == 0) continue;
                if (!kv.Key.EndsWith(dotSuffix, StringComparison.OrdinalIgnoreCase))
                    continue;

                var raw = kv.Value[0]?.Trim() ?? "";
                if (string.IsNullOrEmpty(raw))
                {
                    assign(null);
                    return;
                }

                if (TryParsePositiveGeoId(raw, out var n))
                {
                    assign(n);
                    return;
                }
            }
        }

        /// <summary>
        /// Отсекает невозможные годы основания (в т.ч. из подделанного query string) и несогласованные пары «с»/«по».
        /// </summary>
        private static void NormalizeCatalogFoundationYears(SearchModel? model)
        {
            if (model == null) return;
            var max = DateTime.UtcNow.Year;
            if (model.FoundationYearFrom.HasValue)
            {
                var y = model.FoundationYearFrom.Value;
                if (y < 1 || y > max) model.FoundationYearFrom = null;
            }
            if (model.FoundationYearTo.HasValue)
            {
                var y = model.FoundationYearTo.Value;
                if (y < 1 || y > max) model.FoundationYearTo = null;
            }
            if (model.FoundationYearFrom.HasValue && model.FoundationYearTo.HasValue
                && model.FoundationYearFrom.Value > model.FoundationYearTo.Value)
            {
                model.FoundationYearTo = null;
            }
        }

        private void SearchObjects(SearchModel model, bool usePagination = true, CatalogSearchMode searchMode = CatalogSearchMode.Catalog)
        {
            try
            {
                NormalizeCatalogFoundationYears(model);

                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                var regionsWithoutDistricts = QueryRegionIdsWithNoDistricts(connection);
                if (model.RegionId.HasValue && regionsWithoutDistricts.Contains(model.RegionId.Value))
                    model.DistrictId = null;

                var parameters = new DynamicParameters();
                var whereClauses = new List<string>();
                var exMode = ResolveReportExistenceMode(searchMode, model.ReportExistence);

                string ateWhere = exMode switch
                {
                    ReportExistenceSqlMode.Catalog or ReportExistenceSqlMode.ExistsOnly =>
                        " WHERE (b.existence = 'существует' OR b.existence IS NULL)",
                    ReportExistenceSqlMode.Any => "",
                    ReportExistenceSqlMode.NotExistsOnly =>
                        " WHERE (b.existence IS NOT NULL AND b.existence <> 'существует')",
                    _ => ""
                };

                string airWhere = exMode switch
                {
                    ReportExistenceSqlMode.NotExistsOnly => " WHERE FALSE",
                    _ => ""
                };

                string rwWhere = exMode switch
                {
                    ReportExistenceSqlMode.Catalog or ReportExistenceSqlMode.ExistsOnly =>
                        " WHERE (rw.existence = 'существует' OR rw.existence IS NULL)",
                    ReportExistenceSqlMode.Any => "",
                    ReportExistenceSqlMode.NotExistsOnly =>
                        " WHERE (rw.existence IS NOT NULL AND rw.existence <> 'существует')",
                    _ => ""
                };

                string fgoWhere = exMode switch
                {
                    ReportExistenceSqlMode.Catalog or ReportExistenceSqlMode.ExistsOnly =>
                        " WHERE (f.existence = 'существует' OR f.existence IS NULL)",
                    ReportExistenceSqlMode.Any => "",
                    ReportExistenceSqlMode.NotExistsOnly =>
                        " WHERE (f.existence IS NOT NULL AND f.existence <> 'существует')",
                    _ => ""
                };

                // --- ИСПРАВЛЕНО: soato::numeric в CTE ---
                var cteSql = $@"
                    WITH AllObjects AS (
                        SELECT
                            'ATE' AS ObjectType, b.""kod_ate"" AS ObjectId, b.""namerus"" AS NameRu, b.""namebel"" AS NameBe,
                            rt.ratename AS TypeName, o.obl AS RegionName, r.ra AS DistrictName,
                            b.""x_wgs"" AS Latitude, b.""y_wgs"" AS Longitude,
                            p.""popular"" AS Population,
                            CAST(NULL AS float) AS Elevation,
                            EXTRACT(YEAR FROM b.""{AteDateColumn}""::timestamp)::int AS FoundationYear,
                            b.nomenklat AS Nomenklat, b.existence AS StatusName, b.""{AteDateColumn}"" AS CreatedDate,
                            b.id_obl AS RegionId, b.id_ra AS DistrictId,
                            b.soato::numeric AS PostalCode
                        FROM kn_dbate b
                        LEFT JOIN kn_obl o ON b.id_obl = o.id_obl
                        LEFT JOIN kn_ra r ON b.id_ra = r.id_ra
                        LEFT JOIN kn_rodate rt ON b.id_rodate = rt.id_rodate
                        LEFT JOIN (
                            SELECT ""kod_ate"", ""popular"", ROW_NUMBER() OVER(PARTITION BY ""kod_ate"" ORDER BY ""datacensus"" DESC) as rn
                            FROM kn_hpopular
                        ) p ON b.""kod_ate"" = p.""kod_ate"" AND p.rn = 1
                        {ateWhere}
                        UNION ALL
                        SELECT
                            'AIR' AS ObjectType, a.""id_air"", a.""namerus"", a.""namebel"", a.""category"", o.obl, r.ra,
                            a.""x_wgs"", a.""y_wgs"", NULL, NULL, EXTRACT(YEAR FROM a.""datereg""::timestamp)::int, a.nomenklat, 'существует', a.""datereg"",
                            a.obl, a.ra, NULL
                        FROM kn_dbair a
                        LEFT JOIN kn_obl o ON a.obl = o.id_obl
                        LEFT JOIN kn_ra r ON a.ra = r.id_ra
                        {airWhere}
                        UNION ALL
                        SELECT
                            'RW' AS ObjectType, rw.""id_rw"", rw.""namerus"", rw.""namebel"", c.nkod, o.obl, r.ra,
                            rw.""x_wgs"", rw.""y_wgs"", NULL, NULL, EXTRACT(YEAR FROM rw.""datereg""::timestamp)::int, rw.nomenklat, rw.existence, rw.""datereg"",
                            rw.obl, rw.ra, NULL
                        FROM kn_dbrw rw
                        LEFT JOIN kn_obl o ON rw.obl = o.id_obl
                        LEFT JOIN kn_ra r ON rw.ra = r.id_ra
                        LEFT JOIN kn_category c ON rw.category = c.id_categor
                        {rwWhere}
                        UNION ALL
                        SELECT
                            'FGO' AS ObjectType, f.""id_fgo"", f.""namerus"", f.""namebel"", rf.rfgoname, o.obl, r.ra,
                            f.""x_wgs"", f.""y_wgs"",
                            NULL,
                            f.depth,
                            EXTRACT(YEAR FROM f.""datereg""::timestamp)::int, f.nomenklat, f.existence, f.""datereg"",
                            f.obl, f.ra, NULL
                        FROM kn_dbfgo f
                        LEFT JOIN kn_obl o ON f.obl = o.id_obl
                        LEFT JOIN kn_ra r ON f.ra = r.id_ra
                        LEFT JOIN kn_rodfgo rf ON f.rodfgo = rf.id_rodfgo
                        {fgoWhere}
                    )";

                if (!string.IsNullOrWhiteSpace(model.SearchQuery))
                {
                    whereClauses.Add("(NameRu LIKE @SearchTerm OR NameBe LIKE @SearchTerm)");
                    parameters.Add("@SearchTerm", $"%{model.SearchQuery.Trim()}%");
                }

                var subtypeByType = searchMode == CatalogSearchMode.AdminReport
                    ? ParseReportSubtypeTags(model.ReportSubtypeTags)
                    : new Dictionary<string, List<string>>(StringComparer.OrdinalIgnoreCase);

                List<string>? reportTypeList = null;
                if (searchMode == CatalogSearchMode.AdminReport && model.ReportObjectTypes != null)
                {
                    reportTypeList = model.ReportObjectTypes
                        .Where(x => !string.IsNullOrWhiteSpace(x))
                        .Select(x => x.Trim().ToUpperInvariant())
                        .Distinct()
                        .ToList();
                    if (reportTypeList.Count == 0)
                        reportTypeList = null;
                }

                if (searchMode == CatalogSearchMode.AdminReport && reportTypeList == null && subtypeByType.Count > 0)
                    reportTypeList = subtypeByType.Keys.Distinct(StringComparer.OrdinalIgnoreCase).ToList();

                if (searchMode == CatalogSearchMode.AdminReport && reportTypeList != null && reportTypeList.Count > 0)
                {
                    var orParts = new List<string>();
                    for (var i = 0; i < reportTypeList.Count; i++)
                    {
                        var t = reportTypeList[i];
                        var pOt = "@repOt_" + i;
                        parameters.Add(pOt, t);
                        if (subtypeByType.TryGetValue(t, out var subs) && subs.Count > 0)
                        {
                            var pSub = "@repSub_" + i;
                            parameters.Add(pSub, subs.ToArray());
                            orParts.Add($"(ObjectType = {pOt} AND TypeName = ANY({pSub}))");
                        }
                        else
                            orParts.Add($"(ObjectType = {pOt})");
                    }
                    whereClauses.Add("(" + string.Join(" OR ", orParts) + ")");
                }
                else if (!string.IsNullOrWhiteSpace(model.ObjectType))
                {
                    whereClauses.Add("ObjectType = @ObjectType");
                    parameters.Add("@ObjectType", model.ObjectType);
                }
                
                if (!string.IsNullOrWhiteSpace(model.FirstLetter) && model.FirstLetter != "Все")
                {
                    whereClauses.Add("NameRu LIKE @FirstLetter");
                    parameters.Add("@FirstLetter", $"{model.FirstLetter.Trim()}%");
                }
                
                if (model.RegionId.HasValue)
                {
                    whereClauses.Add("RegionId = @RegionId");
                    parameters.Add("@RegionId", model.RegionId.Value);
                }
                
                if (model.DistrictId.HasValue)
                {
                    whereClauses.Add("DistrictId = @DistrictId");
                    parameters.Add("@DistrictId", model.DistrictId.Value);
                }
                
                if (model.MinPopulation.HasValue)
                {
                    whereClauses.Add("Population IS NOT NULL AND Population >= @MinPopulation");
                    parameters.Add("@MinPopulation", model.MinPopulation.Value);
                }
                
                if (model.MaxPopulation.HasValue)
                {
                    whereClauses.Add("Population IS NOT NULL AND Population <= @MaxPopulation");
                    parameters.Add("@MaxPopulation", model.MaxPopulation.Value);
                }
                
                if (model.MinElevation.HasValue)
                {
                    whereClauses.Add("Elevation IS NOT NULL AND Elevation >= @MinElevation");
                    parameters.Add("@MinElevation", model.MinElevation.Value);
                }
                
                if (model.MaxElevation.HasValue)
                {
                    whereClauses.Add("Elevation IS NOT NULL AND Elevation <= @MaxElevation");
                    parameters.Add("@MaxElevation", model.MaxElevation.Value);
                }
                
                if (model.FoundationYearFrom.HasValue)
                {
                    whereClauses.Add("FoundationYear IS NOT NULL AND FoundationYear >= @FoundationYearFrom");
                    parameters.Add("@FoundationYearFrom", model.FoundationYearFrom.Value);
                }
                
                if (model.FoundationYearTo.HasValue)
                {
                    whereClauses.Add("FoundationYear IS NOT NULL AND FoundationYear <= @FoundationYearTo");
                    parameters.Add("@FoundationYearTo", model.FoundationYearTo.Value);
                }
                
                if (model.CreatedFrom.HasValue)
                {
                    whereClauses.Add("CreatedDate >= @CreatedFrom");
                    parameters.Add("@CreatedFrom", model.CreatedFrom.Value.Date);
                }
                
                if (model.CreatedTo.HasValue)
                {
                    whereClauses.Add("CreatedDate <= @CreatedTo");
                    parameters.Add("@CreatedTo", model.CreatedTo.Value.Date.AddDays(1).AddTicks(-1));
                }
                
                var whereClauseSql = whereClauses.Any() ? " WHERE " + string.Join(" AND ", whereClauses) : "";
                
                var countQuery = $"{cteSql} SELECT COUNT(*) FROM AllObjects {whereClauseSql}";
                model.TotalCount = connection.ExecuteScalar<int>(countQuery, parameters);
                
                var dataQueryBuilder = new StringBuilder();
                dataQueryBuilder.Append(cteSql);
                dataQueryBuilder.Append($"SELECT * FROM AllObjects {whereClauseSql}");
                
                string orderBy;
                switch (model.SortBy)
                {
                    case "name_asc": orderBy = "NameRu ASC"; break;
                    case "name_desc": orderBy = "NameRu DESC"; break;
                    case "type_asc": orderBy = "TypeName ASC"; break;
                    case "type_desc": orderBy = "TypeName DESC"; break;
                    case "region_asc": orderBy = "RegionName ASC"; break;
                    case "region_desc": orderBy = "RegionName DESC"; break;
                    case "district_asc": orderBy = "DistrictName ASC"; break;
                    case "district_desc": orderBy = "DistrictName DESC"; break;
                    case "population_desc": orderBy = "Population DESC"; break;
                    case "elevation_desc": orderBy = "Elevation DESC"; break;
                    case "date_desc": orderBy = "CreatedDate DESC"; break;
                    default: orderBy = "NameRu ASC"; break;
                }
                
                dataQueryBuilder.Append($" ORDER BY {orderBy}");
                
                if (usePagination)
                {
                    dataQueryBuilder.Append(" OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY");
                    parameters.Add("@Offset", (model.Page - 1) * model.PageSize);
                    parameters.Add("@PageSize", model.PageSize);
                }
                
                var results = connection.Query<SearchResult>(dataQueryBuilder.ToString(), parameters).ToList();
                model.Results = results;
                
                foreach (var result in model.Results)
                {
                    if (result.Longitude.HasValue && result.Latitude.HasValue)
                    {
                        result.Coordinates = $"{result.Latitude:F6}, {result.Longitude:F6}";
                    }
                    else
                    {
                        result.Coordinates = "Нет данных";
                    }
                }
                
                _logger?.LogInformation("Поиск вернул {Count} результатов, всего {TotalCount}", results.Count, model.TotalCount);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при поиске объектов через SQL-запрос");
                model.Results = new List<SearchResult>();
                model.TotalCount = 0;
                TempData["ErrorMessage"] = $"Ошибка при поиске: {ex.Message}";
            }
        }

        private void GenerateAlphabet(SearchModel model)
        {
            model.Alphabet = new List<string> { "Все" };
            for (char c = 'А'; c <= 'Я'; c++)
            {
                model.Alphabet.Add(c.ToString());
            }
            model.Alphabet.Add("Ё");
            for (char c = 'A'; c <= 'Z'; c++)
            {
                model.Alphabet.Add(c.ToString());
            }
        }

        private Dictionary<string, int> GetCatalogStatistics()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                var stats = new Dictionary<string, int>
                {
                    ["Населенные пункты"] = connection.ExecuteScalar<int>(
                        "SELECT COUNT(*) FROM kn_dbate WHERE \"existence\" = 'существует' OR \"existence\" IS NULL"),
                    ["Аэропорты"] = connection.ExecuteScalar<int>(
                        "SELECT COUNT(*) FROM kn_dbair"),
                    ["Железнодорожные объекты"] = connection.ExecuteScalar<int>(
                        "SELECT COUNT(*) FROM kn_dbrw WHERE \"existence\" = 'существует' OR \"existence\" IS NULL"),
                    ["Физ.-гео. объекты"] = connection.ExecuteScalar<int>(
                        "SELECT COUNT(*) FROM kn_dbfgo WHERE \"existence\" = 'существует' OR \"existence\" IS NULL")
                };
                return stats;
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении статистики");
                return new Dictionary<string, int>
                {
                    ["Населенные пункты"] = 0,
                    ["Аэропорты"] = 0,
                    ["Железнодорожные объекты"] = 0,
                    ["Физ.-гео. объекты"] = 0
                };
            }
        }

        [HttpGet]
        public IActionResult Error(string message)
        {
            ViewBag.ErrorMessage = message ?? "Произошла непредвиденная ошибка";
            return View();
        }

        [HttpPost]
        public IActionResult ExportSelectedToPdf(List<BulkExportItem> items)
        {
            try
            {
                if (items == null || !items.Any())
                {
                    return RedirectToAction("Index");
                }
                
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                var results = new List<SearchResult>();
                
                var ateIds = items.Where(x => x.Type == "ATE").Select(x => x.Id).ToList();
                var airIds = items.Where(x => x.Type == "AIR").Select(x => x.Id).ToList();
                var rwIds = items.Where(x => x.Type == "RW").Select(x => x.Id).ToList();
                var fgoIds = items.Where(x => x.Type == "FGO").Select(x => x.Id).ToList();
                
                if (ateIds.Any())
                {
                    var sql = $@"SELECT 'ATE' as ObjectType, b.""kod_ate"" as ObjectId, b.namerus as NameRu,
                        o.obl as RegionName, r.ra as DistrictName, b.x_wgs as Latitude, b.y_wgs as Longitude
                        FROM kn_dbate b
                        LEFT JOIN kn_obl o ON b.id_obl = o.id_obl
                        LEFT JOIN kn_ra r ON b.id_ra = r.id_ra
                        WHERE b.""kod_ate"" IN @Ids";
                    results.AddRange(connection.Query<SearchResult>(sql, new { Ids = ateIds }));
                }
                
                if (airIds.Any())
                {
                    var sql = @"SELECT 'AIR' as ObjectType, a.id_air as ObjectId, a.namerus as NameRu,
                        o.obl as RegionName, r.ra as DistrictName, a.x_wgs as Latitude, a.y_wgs as Longitude
                        FROM kn_dbair a
                        LEFT JOIN kn_obl o ON a.obl = o.id_obl
                        LEFT JOIN kn_ra r ON a.ra = r.id_ra
                        WHERE a.id_air IN @Ids";
                    results.AddRange(connection.Query<SearchResult>(sql, new { Ids = airIds }));
                }
                
                if (rwIds.Any())
                {
                    var sql = $@"SELECT 'RW' as ObjectType, r.""id_rw"" as ObjectId, r.namerus as NameRu,
                        o.obl as RegionName, ra.ra as DistrictName, r.x_wgs as Latitude, r.y_wgs as Longitude
                        FROM kn_dbrw r
                        LEFT JOIN kn_obl o ON r.obl = o.id_obl
                        LEFT JOIN kn_ra ra ON r.ra = ra.id_ra
                        WHERE r.""id_rw"" IN @Ids";
                    results.AddRange(connection.Query<SearchResult>(sql, new { Ids = rwIds }));
                }
                
                if (fgoIds.Any())
                {
                    var sql = @"SELECT 'FGO' as ObjectType, f.id_fgo as ObjectId, f.namerus as NameRu,
                        o.obl as RegionName, r.ra as DistrictName, f.x_wgs as Latitude, f.y_wgs as Longitude
                        FROM kn_dbfgo f
                        LEFT JOIN kn_obl o ON f.obl = o.id_obl
                        LEFT JOIN kn_ra r ON f.ra = r.id_ra
                        WHERE f.id_fgo IN @Ids";
                    results.AddRange(connection.Query<SearchResult>(sql, new { Ids = fgoIds }));
                }
                
                string fontPath = Path.Combine(_hostingEnvironment.WebRootPath, "fonts", "tahoma.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                Font headerFont = new Font(baseFont, 10, Font.BOLD);
                Font cellFont = new Font(baseFont, 9, Font.NORMAL);
                
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    Document document = new Document(PageSize.A4.Rotate(), 25, 25, 30, 30);
                    PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                    document.Open();
                    
                    var title = new Paragraph($"Выгрузка выбранных объектов", new Font(baseFont, 14, Font.BOLD));
                    title.Alignment = Element.ALIGN_CENTER;
                    document.Add(title);
                    
                    document.Add(new Paragraph($"Всего объектов: {results.Count}", new Font(baseFont, 10, Font.ITALIC))
                    {
                        Alignment = Element.ALIGN_CENTER,
                        SpacingAfter = 15
                    });
                    
                    PdfPTable table = new PdfPTable(5);
                    table.WidthPercentage = 100;
                    table.SetWidths(new float[] { 1f, 3f, 2f, 2f, 2f });
                    
                    string[] headers = { "Тип", "Название", "Область", "Район", "Координаты" };
                    foreach (string header in headers)
                    {
                        PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
                        cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                        cell.HorizontalAlignment = Element.ALIGN_CENTER;
                        cell.Padding = 5;
                        table.AddCell(cell);
                    }
                    
                    foreach (var item in results)
                    {
                        string coords = (item.Latitude.HasValue && item.Longitude.HasValue)
                            ? $"{item.Latitude:F5}, {item.Longitude:F5}"
                            : "-";
                        table.AddCell(new Phrase(ObjectTypeDisplayForReport(item.ObjectType), cellFont));
                        table.AddCell(new Phrase(item.NameRu, cellFont));
                        table.AddCell(new Phrase(item.RegionName ?? "-", cellFont));
                        table.AddCell(new Phrase(item.DistrictName ?? "-", cellFont));
                        table.AddCell(new Phrase(coords, cellFont));
                    }
                    
                    document.Add(table);
                    document.Close();
                    writer.Close();
                    
                    return File(memoryStream.ToArray(), "application/pdf", $"Selected_Objects_{DateTime.Now:yyyyMMdd_HHmmss}.pdf");
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при массовом экспорте в PDF");
                return RedirectToAction("Index");
            }
        }

        [HttpGet]
        [Route("api/catalog/stats")]
        public IActionResult GetStats()
        {
            try
            {
                var stats = GetCatalogStatistics();
                return Json(new { success = true, data = stats });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении статистики");
                return Json(new { success = false, error = ex.Message });
            }
        }

        [HttpGet]
        [Route("api/catalog/type/{type}")]
        public IActionResult GetObjectsByType(string type, int page = 1, int pageSize = 20)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                var model = new SearchModel
                {
                    ObjectType = type.ToUpper(),
                    Page = page,
                    PageSize = pageSize
                };
                SearchObjects(model);
                return Json(new
                {
                    success = true,
                    data = new
                    {
                        objects = model.Results,
                        total = model.TotalCount,
                        page = page,
                        pageSize = pageSize
                    }
                });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении объектов типа {Type}", type);
                return Json(new { success = false, error = ex.Message });
            }
        }

        [HttpGet]
        public IActionResult ExportToPdf(
            [FromQuery, Bind(Prefix = "")] SearchModel model,
            int? regionId = null,
            int? districtId = null)
        {
            try
            {
                if (model == null) model = new SearchModel();
                MergeGeoFiltersFromRequestQuery(model, Request);
                if (regionId.HasValue && regionId.Value > 0)
                    model.RegionId = regionId.Value;
                if (districtId.HasValue && districtId.Value > 0)
                    model.DistrictId = districtId.Value;

                SearchObjects(model, usePagination: false);
                
                string fontPath = Path.Combine(_hostingEnvironment.WebRootPath, "fonts", "tahoma.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                Font headerFont = new Font(baseFont, 10, Font.BOLD);
                Font cellFont = new Font(baseFont, 9, Font.NORMAL);
                
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    Document document = new Document(PageSize.A4.Rotate(), 25, 25, 30, 30);
                    PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                    document.Open();
                    
                    var title = new Paragraph($"Отчет по географическим объектам", new Font(baseFont, 16, Font.BOLD));
                    title.Alignment = Element.ALIGN_CENTER;
                    document.Add(title);
                    
                    var subTitle = new Paragraph($"Сформирован: {DateTime.Now:dd.MM.yyyy HH:mm}. Найдено объектов: {model.Results.Count}", new Font(baseFont, 8, Font.ITALIC));
                    subTitle.Alignment = Element.ALIGN_CENTER;
                    subTitle.SpacingAfter = 20;
                    document.Add(subTitle);
                    
                    PdfPTable table = new PdfPTable(6);
                    table.WidthPercentage = 100;
                    table.SetWidths(new float[] { 1f, 3f, 2f, 2f, 2f, 1f });
                    
                    string[] headers = { "Тип", "Название (рус.)", "Область", "Район", "Координаты", "Население" };
                    foreach (string header in headers)
                    {
                        PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
                        cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                        cell.HorizontalAlignment = Element.ALIGN_CENTER;
                        table.AddCell(cell);
                    }
                    
                    foreach (var item in model.Results)
                    {
                        table.AddCell(new Phrase(ObjectTypeDisplayForReport(item.ObjectType), cellFont));
                        table.AddCell(new Phrase(item.NameRu, cellFont));
                        table.AddCell(new Phrase(item.RegionName ?? "Н/Д", cellFont));
                        table.AddCell(new Phrase(item.DistrictName ?? "Н/Д", cellFont));
                        table.AddCell(new Phrase(item.Coordinates ?? "Н/Д", cellFont));
                        table.AddCell(new Phrase(item.Population?.ToString() ?? "-", cellFont));
                    }
                    
                    document.Add(table);
                    document.Close();
                    writer.Close();
                    
                    var bytes = memoryStream.ToArray();
                    return File(bytes, "application/pdf", $"GeographicReport_{DateTime.Now:yyyyMMdd}.pdf");
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при экспорте в PDF с использованием iTextSharp");
                TempData["ErrorMessage"] = $"Ошибка при экспорте в PDF: {ex.Message}";
                return RedirectToAction("Index");
            }
        }

        [HttpGet]
        public IActionResult ExportAdminReportPdf(
            [FromQuery, Bind(Prefix = "")] SearchModel model,
            string reportKind,
            string referenceGroup = null,
            int? regionId = null,
            int? districtId = null)
        {
            try
            {
                if (model == null) model = new SearchModel();
                MergeGeoFiltersFromRequestQuery(model, Request);
                if (regionId.HasValue && regionId.Value > 0)
                    model.RegionId = regionId.Value;
                if (districtId.HasValue && districtId.Value > 0)
                    model.DistrictId = districtId.Value;

                SearchObjects(model, usePagination: false, CatalogSearchMode.AdminReport);
                
                string fontPath = Path.Combine(_hostingEnvironment.WebRootPath, "fonts", "tahoma.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                Font headerFont = new Font(baseFont, 10, Font.BOLD);
                Font cellFont = new Font(baseFont, 9, Font.NORMAL);
                
                string datePart = "";
                if (model.CreatedFrom.HasValue) datePart += $" с {model.CreatedFrom:dd.MM.yyyy}";
                if (model.CreatedTo.HasValue) datePart += $" по {model.CreatedTo:dd.MM.yyyy}";
                
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    Document document = new Document(PageSize.A4.Rotate(), 25, 25, 30, 30);
                    PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                    document.Open();
                    
                    var title = reportKind switch
                    {
                        "time_list" => "Отчет по критериям и периоду",
                        "count_by_type" => "Отчет: количество объектов по типам",
                        "count_by_status" => "Отчет: количество по статусу существования",
                        "ref_list" => $"Отчет: эталонные сведения ({referenceGroup})",
                        "ref_counts" => $"Отчет: количество по эталонным значениям ({referenceGroup})",
                        _ => "Отчет"
                    };
                    
                    var reportTitle = new Paragraph(title, new Font(baseFont, 16, Font.BOLD));
                    reportTitle.Alignment = Element.ALIGN_CENTER;
                    document.Add(reportTitle);
                    
                    var subTitle = new Paragraph(
                        $"Сформирован: {DateTime.Now:dd.MM.yyyy HH:mm}. Найдено объектов: {model.Results.Count}.{datePart}",
                        new Font(baseFont, 8, Font.ITALIC));
                    subTitle.Alignment = Element.ALIGN_CENTER;
                    subTitle.SpacingAfter = 20;
                    document.Add(subTitle);
                    
                    if (reportKind == "time_list")
                    {
                        PdfPTable table = new PdfPTable(8);
                        table.WidthPercentage = 100;
                        table.SetWidths(new float[] { 0.9f, 1.6f, 2.2f, 1.8f, 1.8f, 1.8f, 0.9f, 1.2f });
                        string[] headers = { "Тип", "Подтип", "Название (рус.)", "Область", "Район", "Координаты", "Насел.", "Статус" };
                        foreach (string header in headers)
                        {
                            PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
                            cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                            cell.HorizontalAlignment = Element.ALIGN_CENTER;
                            table.AddCell(cell);
                        }
                        foreach (var item in model.Results)
                        {
                            table.AddCell(new Phrase(ObjectTypeDisplayForReport(item.ObjectType), cellFont));
                            table.AddCell(new Phrase(item.TypeName ?? "—", cellFont));
                            table.AddCell(new Phrase(item.NameRu ?? "-", cellFont));
                            table.AddCell(new Phrase(item.RegionName ?? "Н/Д", cellFont));
                            table.AddCell(new Phrase(item.DistrictName ?? "Н/Д", cellFont));
                            table.AddCell(new Phrase(item.Coordinates ?? "Н/Д", cellFont));
                            table.AddCell(new Phrase(item.Population?.ToString() ?? "-", cellFont));
                            table.AddCell(new Phrase(item.StatusName ?? "—", cellFont));
                        }
                        document.Add(table);
                    }
                    else if (reportKind == "count_by_type")
                    {
                        var rows = model.Results
                            .GroupBy(x => x.ObjectType ?? "Н/Д")
                            .OrderBy(g => g.Key)
                            .Select(g => new { Type = g.Key, Count = g.Count() })
                            .ToList();
                        
                        PdfPTable table = new PdfPTable(2);
                        table.WidthPercentage = 100;
                        table.SetWidths(new float[] { 3f, 1.5f });
                        string[] headers = { "Тип", "Количество" };
                        foreach (string header in headers)
                        {
                            PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
                            cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                            cell.HorizontalAlignment = Element.ALIGN_CENTER;
                            table.AddCell(cell);
                        }
                        foreach (var r in rows)
                        {
                            table.AddCell(new Phrase(ObjectTypeDisplayForReport(r.Type), cellFont));
                            table.AddCell(new Phrase(r.Count.ToString(), cellFont));
                        }
                        document.Add(table);
                    }
                    else if (reportKind == "count_by_status")
                    {
                        var rows = model.Results
                            .GroupBy(x => string.IsNullOrWhiteSpace(x.StatusName) ? "—" : x.StatusName.Trim())
                            .OrderBy(g => g.Key)
                            .Select(g => new { Status = g.Key, Count = g.Count() })
                            .ToList();

                        PdfPTable table = new PdfPTable(2);
                        table.WidthPercentage = 100;
                        table.SetWidths(new float[] { 3f, 1.5f });
                        string[] headers = { "Статус (existence)", "Количество" };
                        foreach (string header in headers)
                        {
                            PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
                            cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                            cell.HorizontalAlignment = Element.ALIGN_CENTER;
                            table.AddCell(cell);
                        }
                        foreach (var r in rows)
                        {
                            table.AddCell(new Phrase(r.Status, cellFont));
                            table.AddCell(new Phrase(r.Count.ToString(), cellFont));
                        }
                        document.Add(table);
                    }
                    else if (reportKind == "ref_list" || reportKind == "ref_counts")
                    {
                        string groupTitle = referenceGroup ?? "group";
                        Func<SearchResult, string> selector = referenceGroup?.ToLowerInvariant() switch
                        {
                            "regions" => x => x.RegionName ?? "Н/Д",
                            "districts" => x => x.DistrictName ?? "Н/Д",
                            "types" => x => x.ObjectType ?? "Н/Д",
                            _ => x => "Н/Д"
                        };
                        
                        var groups = model.Results
                            .Select(selector)
                            .Where(x => !string.IsNullOrWhiteSpace(x))
                            .Distinct()
                            .OrderBy(x => x)
                            .ToList();
                        
                        PdfPTable table = reportKind == "ref_list" ? new PdfPTable(1) : new PdfPTable(2);
                        table.WidthPercentage = 100;
                        
                        if (reportKind == "ref_list")
                        {
                            table.SetWidths(new float[] { 1f });
                            PdfPCell cell = new PdfPCell(new Phrase($"Эталон: {groupTitle}", headerFont));
                            cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                            cell.HorizontalAlignment = Element.ALIGN_CENTER;
                            table.AddCell(cell);
                            foreach (var g in groups)
                            {
                                var label = string.Equals(referenceGroup, "types", StringComparison.OrdinalIgnoreCase)
                                    ? ObjectTypeDisplayForReport(g)
                                    : g;
                                table.AddCell(new Phrase(label, cellFont));
                            }
                        }
                        else
                        {
                            table.SetWidths(new float[] { 3f, 1.2f });
                            string[] headers = { $"Эталон ({groupTitle})", "Количество" };
                            foreach (string header in headers)
                            {
                                PdfPCell cell = new PdfPCell(new Phrase(header, headerFont));
                                cell.BackgroundColor = BaseColor.LIGHT_GRAY;
                                cell.HorizontalAlignment = Element.ALIGN_CENTER;
                                table.AddCell(cell);
                            }
                            foreach (var g in groups)
                            {
                                var cnt = model.Results.Count(x => selector(x) == g);
                                var label = string.Equals(referenceGroup, "types", StringComparison.OrdinalIgnoreCase)
                                    ? ObjectTypeDisplayForReport(g)
                                    : g;
                                table.AddCell(new Phrase(label, cellFont));
                                table.AddCell(new Phrase(cnt.ToString(), cellFont));
                            }
                        }
                        document.Add(table);
                    }
                    else
                    {
                        document.Add(new Paragraph("Неизвестный тип отчета.", cellFont));
                    }
                    
                    document.Close();
                    writer.Close();
                    
                    var bytes = memoryStream.ToArray();
                    return File(bytes, "application/pdf", $"GeographicReport_{reportKind ?? "report"}_{DateTime.Now:yyyyMMddHHmm}.pdf");
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при экспорте админского отчёта");
                TempData["ErrorMessage"] = $"Ошибка при экспорте отчета: {ex.Message}";
                return RedirectToAction("Index");
            }
        }

        [HttpGet]
        public IActionResult QuickCheck()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                var checks = new List<dynamic>();
                
                checks.Add(new { Check = "kn_dbate", Count = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbate") });
                checks.Add(new { Check = "kn_dbair", Count = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbair") });
                checks.Add(new { Check = "kn_dbrw", Count = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbrw") });
                checks.Add(new { Check = "kn_dbfgo", Count = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbfgo") });
                
                var sampleAte = connection.QueryFirstOrDefault(
                    $"SELECT \"kod_ate\", \"namerus\" FROM kn_dbate WHERE \"existence\" = 'существует' LIMIT 1");
                var sampleAir = connection.QueryFirstOrDefault(
                    "SELECT id_air, namerus FROM kn_dbair LIMIT 1");
                
                return Json(new
                {
                    success = true,
                    checks = checks,
                    sampleAte = sampleAte,
                    sampleAir = sampleAir
                });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, error = ex.Message });
            }
        }

        [HttpGet]
        [Route("Catalog/Airport/ExportPdf/{id:int}")]
        public IActionResult ExportAirportDetailsToPdf(int id)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                
                var airport = connection.QueryFirstOrDefault<Airport>(
                    @"SELECT
                        a.id_air as ID_AIR, a.namerus as NAMERUS, a.namebel as NAMEBEL, a.namelat as NAMELAT, a.category as CATEGORY, a.nomenklat as NOMENKLAT,
                        a.x_wgs as Latitude, a.y_wgs as Longitude, a.datereg::timestamp as DATEREG,
                        a.geopr as LocationDescription, a.udarrus as UDARRUS, a.udarbel as UDARBEL,
                        o.obl as RegionName, r.ra as DistrictName
                    FROM kn_dbair a
                    LEFT JOIN kn_obl o ON a.obl = o.id_obl
                    LEFT JOIN kn_ra r ON a.ra = r.id_ra
                    WHERE a.id_air = @Id",
                    new { Id = id });
                
                if (airport == null)
                {
                    TempData["ErrorMessage"] = "Аэропорт для экспорта не найден.";
                    return RedirectToAction("Index");
                }
                
                var changeHistory = connection.Query(
                    @"SELECT redate as ChangeDate, changes as ChangeDescription, namedoc as DocumentName
                    FROM kn_hchangeair WHERE id_air = @Id ORDER BY redate DESC",
                    new { Id = id }).ToList();
                
                string fontPath = Path.Combine(_hostingEnvironment.WebRootPath, "fonts", "tahoma.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                Font titleFont = new Font(baseFont, 16, Font.BOLD);
                Font headerFont = new Font(baseFont, 12, Font.BOLD);
                Font regularFont = new Font(baseFont, 10, Font.NORMAL);
                Font boldFont = new Font(baseFont, 10, Font.BOLD);
                
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    Document document = new Document(PageSize.A4, 40, 40, 40, 40);
                    PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                    document.Open();
                    
                    var title = new Paragraph($"Паспорт объекта: {airport.NAMERUS}", titleFont);
                    title.Alignment = Element.ALIGN_CENTER;
                    title.SpacingAfter = 20;
                    document.Add(title);
                    
                    PdfPTable mainInfoTable = new PdfPTable(2);
                    mainInfoTable.WidthPercentage = 100;
                    mainInfoTable.SetWidths(new float[] { 1f, 2f });
                    mainInfoTable.SpacingAfter = 20;
                    
                    Action<string, string> AddRow = (key, value) =>
                    {
                        mainInfoTable.AddCell(new Phrase(key, boldFont));
                        mainInfoTable.AddCell(new Phrase(value ?? "Нет данных", regularFont));
                    };
                    
                    AddRow("Название (бел.)", airport.NAMEBEL);
                    AddRow("Категория", airport.CATEGORY);
                    AddRow("Область", airport.RegionName);
                    AddRow("Район", airport.DistrictName);
                    AddRow("Дата регистрации", airport.DATEREG?.ToString("dd.MM.yyyy") ?? "Нет данных");
                    AddRow("Координаты (WGS-84)", airport.Latitude.HasValue ? $"{airport.Latitude:F6}, {airport.Longitude:F6}" : "Не указаны");
                    AddRow("Геопривязка", airport.LocationDescription);
                    AddRow("Номенклатура", airport.NOMENKLAT);
                    AddRow("Название (лат.)", airport.NAMELAT);
                    AddRow("Ударение (рус.)", airport.UDARRUS);
                    AddRow("Ударение (бел.)", airport.UDARBEL);
                    
                    document.Add(mainInfoTable);
                    
                    if (changeHistory.Any())
                    {
                        var historyHeader = new Paragraph("История изменений", headerFont);
                        historyHeader.SpacingAfter = 10;
                        document.Add(historyHeader);
                        
                        PdfPTable historyTable = new PdfPTable(3);
                        historyTable.WidthPercentage = 100;
                        historyTable.SetWidths(new float[] { 1f, 3f, 2f });
                        historyTable.AddCell(new Phrase("Дата", boldFont));
                        historyTable.AddCell(new Phrase("Описание изменения", boldFont));
                        historyTable.AddCell(new Phrase("Документ", boldFont));
                        
                        foreach (var record in changeHistory)
                        {
                            historyTable.AddCell(new Phrase(record.ChangeDate?.ToString() ?? "", regularFont));
                            historyTable.AddCell(new Phrase(record.ChangeDescription ?? "", regularFont));
                            historyTable.AddCell(new Phrase(record.DocumentName ?? "", regularFont));
                        }
                        document.Add(historyTable);
                    }
                    
                    document.Close();
                    writer.Close();
                    
                    var bytes = memoryStream.ToArray();
                    return File(bytes, "application/pdf", $"Airport_{airport.ID_AIR}_{DateTime.Now:yyyyMMdd}.pdf");
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при экспорте деталей аэропорта в PDF для ID {Id}", id);
                TempData["ErrorMessage"] = $"Ошибка при экспорте в PDF: {ex.Message}";
                return RedirectToAction("DetailsAirport", new { id });
            }
        }

        [HttpGet]
        [Route("Catalog/ATE/ExportPdf/{id:int}")]
        public IActionResult ExportAteDetailsToPdf(int id)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                
                // --- ИСПРАВЛЕНО: soato::numeric, daterЕg с кириллической Е ---
                var ate = connection.QueryFirstOrDefault<AdministrativeUnit>(
                    $@"SELECT
                        b.""kod_ate"" as ID, b.namerus as NAMERUS, b.namebel as NAMEBEL, b.namelat as NAMELAT, b.nomenklat as NOMENKLAT, b.soato::numeric as SOATO,
                        b.sovet as SOVET, b.udarrus as UDARRUS, b.udarbel as UDARBEL, b.x_wgs as Latitude, b.y_wgs as Longitude,
                        b.""{AteDateColumn}""::timestamp as DATEREG, EXTRACT(YEAR FROM b.""{AteDateColumn}""::timestamp)::int as FoundationYear, b.existence as EXISTENCE,
                        o.obl as RegionName, r.ra as DistrictName, rt.ratename as CategoryName,
                        b.sinforus as SINFORUS, b.sinfobel as SINFOBEL
                    FROM kn_dbate b
                    LEFT JOIN kn_obl o ON b.id_obl = o.id_obl
                    LEFT JOIN kn_ra r ON b.id_ra = r.id_ra
                    LEFT JOIN kn_rodate rt ON b.id_rodate = rt.id_rodate
                    WHERE b.""kod_ate"" = @Id",
                    new { Id = id });
                
                if (ate == null)
                {
                    TempData["ErrorMessage"] = "Населенный пункт для экспорта не найден.";
                    return RedirectToAction("Index");
                }
                
                var latestPopulation = connection.QueryFirstOrDefault(
                    @"SELECT popular as Population, EXTRACT(YEAR FROM datacensus::timestamp)::int as PopulationYear
                    FROM kn_hpopular WHERE kod_ate = @KodAte ORDER BY datacensus DESC LIMIT 1",
                    new { KodAte = ate.ID });
                
                if (latestPopulation != null)
                {
                    ate.Population = ToIntNull(latestPopulation.Population);
                    ate.PopulationYear = ToIntNull(latestPopulation.PopulationYear);
                }
                
                var historicalNames = connection.Query<string>(
                    @"SELECT drtnamerus FROM kn_atedrnamerus WHERE kod_ate = @KodAte UNION
                    SELECT drtnamebel FROM kn_atedrnamebel WHERE kod_ate = @KodAte",
                    new { KodAte = ate.ID }).Distinct().ToList();
                
                var populationHistory = connection.Query(
                    @"SELECT datacensus as CensusDate, popular as Population
                    FROM kn_hpopular WHERE kod_ate = @KodAte ORDER BY datacensus DESC",
                    new { KodAte = ate.ID }).ToList();
                
                var changeHistory = connection.Query(
                    @"SELECT redate as ChangeDate, changes as ChangeDescription, namedoc as DocumentName
                    FROM kn_hchangeate WHERE kod_ate = @KodAte ORDER BY redate DESC",
                    new { KodAte = ate.ID }).ToList();
                
                string fontPath = Path.Combine(_hostingEnvironment.WebRootPath, "fonts", "tahoma.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                Font titleFont = new Font(baseFont, 16, Font.BOLD);
                Font headerFont = new Font(baseFont, 12, Font.BOLD);
                Font regularFont = new Font(baseFont, 10, Font.NORMAL);
                Font boldFont = new Font(baseFont, 10, Font.BOLD);
                
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    Document document = new Document(PageSize.A4, 40, 40, 40, 40);
                    PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                    document.Open();
                    
                    var title = new Paragraph($"Паспорт объекта: {ate.NAMERUS}", titleFont)
                    {
                        Alignment = Element.ALIGN_CENTER,
                        SpacingAfter = 20
                    };
                    document.Add(title);
                    
                    document.Add(new Paragraph("Общая информация", headerFont) { SpacingAfter = 10 });
                    
                    var mainInfoTable = new PdfPTable(2);
                    mainInfoTable.WidthPercentage = 100;
                    mainInfoTable.SetWidths(new float[] { 1f, 2f });
                    mainInfoTable.SpacingAfter = 20;
                    
                    Action<string, string> AddRow = (key, value) =>
                    {
                        mainInfoTable.AddCell(new Phrase(key, boldFont));
                        mainInfoTable.AddCell(new Phrase(value ?? "Нет данных", regularFont));
                    };
                    
                    AddRow("Название (бел.)", ate.NAMEBEL);
                    AddRow("Тип", ate.CategoryName);
                    AddRow("Статус", ate.EXISTENCE);
                    AddRow("Область", ate.RegionName);
                    AddRow("Район", ate.DistrictName);
                    AddRow("Сельсовет", ate.SOVET);
                    AddRow("Население", ate.Population.HasValue ? $"{ate.Population:N0} (на {ate.PopulationYear} г.)" : "Нет данных");
                    AddRow("Год основания", ate.FoundationYear?.ToString());
                    AddRow("Координаты (WGS-84)", ate.Latitude.HasValue ? $"{ate.Latitude:F6}, {ate.Longitude:F6}" : "Не указаны");
                    AddRow("Код АТЕ", ate.ID.ToString());
                    AddRow("СОАТО", ate.SOATO?.ToString());
                    
                    document.Add(mainInfoTable);
                    
                    if (populationHistory.Any())
                    {
                        document.Add(new Paragraph("Динамика населения", headerFont) { SpacingAfter = 10 });
                        var popTable = new PdfPTable(2) { WidthPercentage = 100, SpacingAfter = 20 };
                        popTable.AddCell(new Phrase("Дата переписи", boldFont));
                        popTable.AddCell(new Phrase("Численность", boldFont));
                        foreach (var record in populationHistory)
                        {
                            popTable.AddCell(new Phrase(record.CensusDate?.ToString() ?? "", regularFont));
                            popTable.AddCell(new Phrase(record.Population?.ToString() ?? "", regularFont));
                        }
                        document.Add(popTable);
                    }
                    
                    if (historicalNames.Any())
                    {
                        document.Add(new Paragraph("Исторические названия", headerFont) { SpacingAfter = 10 });
                        var nameList = new List(List.UNORDERED);
                        foreach (var name in historicalNames)
                        {
                            nameList.Add(new ListItem(name, regularFont));
                        }
                        document.Add(nameList);
                    }
                    
                    document.Close();
                    writer.Close();
                    
                    var bytes = memoryStream.ToArray();
                    return File(bytes, "application/pdf", $"ATE_{ate.ID}_{DateTime.Now:yyyyMMdd}.pdf");
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при экспорте деталей АТЕ в PDF для ID {Id}", id);
                TempData["ErrorMessage"] = $"Ошибка при экспорте в PDF: {ex.Message}";
                return RedirectToAction("DetailsATE", new { id });
            }
        }

        [HttpGet]
        [Route("Catalog/FGO/ExportPdf/{id:int}")]
        public IActionResult ExportFgoDetailsToPdf(int id)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                
                var fgo = connection.QueryFirstOrDefault<PhysicalGeoObject>(
                    @"SELECT
                        f.id_fgo as ID_FGO, f.namerus as NAMERUS, f.namebel as NAMEBEL, f.namelat as NAMELAT, f.nomenklat as NOMENKLAT, f.x_wgs as Latitude,
                        f.y_wgs as Longitude, f.datereg::timestamp as DATEREG, f.existence as EXISTENCE, f.geopr as Description,
                        f.basriver as Basin, f.pritok as Tributary, f.fall as FALL, f.distance as DISTANCE, f.area as AREA,
                        f.depth as DEPTH, f.sudohod as Navigable, f.specnotes as SpecialNotes, f.udarrus as UDARRUS,
                        f.udarbel as UDARBEL, o.obl as RegionName, rf.rfgoname as TypeName, f.sinforus as SINFORUS, f.sinfobel as SINFOBEL
                    FROM kn_dbfgo f
                    LEFT JOIN kn_obl o ON f.obl = o.id_obl
                    LEFT JOIN kn_rodfgo rf ON f.rodfgo = rf.id_rodfgo
                    WHERE f.id_fgo = @Id",
                    new { Id = id });
                
                if (fgo == null)
                {
                    TempData["ErrorMessage"] = "Объект для экспорта не найден.";
                    return RedirectToAction("Index");
                }
                
                var alternativeNames = connection.Query<string>(
                    @"SELECT drtnamerus FROM kn_fgodrtnamerus WHERE id_fgo = @Id UNION
                    SELECT drtnamebel FROM kn_fgodrtnamebel WHERE id_fgo = @Id",
                    new { Id = id }).Distinct().ToList();
                
                var districts = connection.Query<string>(
                    @"SELECT r.ra as DistrictName FROM kn_dbfgo_obl_ra dor
                    JOIN kn_ra r ON dor.ra = r.id_ra WHERE dor.fgo_id = @Id",
                    new { Id = id }).ToList();
                
                string fontPath = Path.Combine(_hostingEnvironment.WebRootPath, "fonts", "tahoma.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                Font titleFont = new Font(baseFont, 16, Font.BOLD);
                Font headerFont = new Font(baseFont, 12, Font.BOLD);
                Font regularFont = new Font(baseFont, 10, Font.NORMAL);
                Font boldFont = new Font(baseFont, 10, Font.BOLD);
                
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    Document document = new Document(PageSize.A4, 40, 40, 40, 40);
                    PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                    document.Open();
                    
                    var title = new Paragraph($"Паспорт объекта: {fgo.NAMERUS}", titleFont)
                    {
                        Alignment = Element.ALIGN_CENTER,
                        SpacingAfter = 20
                    };
                    document.Add(title);
                    
                    document.Add(new Paragraph("Общая информация", headerFont) { SpacingAfter = 10 });
                    
                    var mainInfoTable = new PdfPTable(2) { WidthPercentage = 100, SpacingAfter = 20 };
                    mainInfoTable.SetWidths(new float[] { 1f, 2f });
                    
                    Action<string, string> AddRow = (key, value) =>
                    {
                        mainInfoTable.AddCell(new Phrase(key, boldFont));
                        mainInfoTable.AddCell(new Phrase(value ?? "Нет данных", regularFont));
                    };
                    
                    AddRow("Название (бел.)", fgo.NAMEBEL);
                    AddRow("Тип объекта", fgo.TypeName);
                    AddRow("Статус", fgo.EXISTENCE);
                    AddRow("Область", fgo.RegionName);
                    AddRow("Районы", districts.Any() ? string.Join(", ", districts) : "Нет данных");
                    AddRow("Дата регистрации", fgo.DATEREG?.ToString("dd.MM.yyyy") ?? "Нет данных");
                    AddRow("Описание", fgo.Description);
                    
                    document.Add(mainInfoTable);
                    
                    document.Add(new Paragraph("Характеристики", headerFont) { SpacingAfter = 10 });
                    
                    var charsTable = new PdfPTable(2) { WidthPercentage = 100, SpacingAfter = 20 };
                    charsTable.SetWidths(new float[] { 1f, 2f });
                    
                    Action<string, string> AddCharRow = (key, value) =>
                    {
                        charsTable.AddCell(new Phrase(key, boldFont));
                        charsTable.AddCell(new Phrase(value ?? "Нет данных", regularFont));
                    };
                    
                    AddCharRow("Координаты (WGS-84)", fgo.Latitude.HasValue ? $"{fgo.Latitude:F6}, {fgo.Longitude:F6}" : "Не указаны");
                    AddCharRow("Площадь, км²", fgo.AREA?.ToString("N2"));
                    AddCharRow("Глубина/Высота, м", fgo.DEPTH?.ToString());
                    AddCharRow("Длина, км", fgo.DISTANCE?.ToString());
                    AddCharRow("Бассейн реки", fgo.Basin);
                    AddCharRow("Приток", fgo.Tributary);
                    AddCharRow("Впадает в", fgo.FALL);
                    AddCharRow("Судоходство", fgo.Navigable);
                    AddCharRow("Особые отметки", fgo.SpecialNotes);
                    
                    document.Add(charsTable);
                    document.Close();
                    writer.Close();
                    
                    var bytes = memoryStream.ToArray();
                    return File(bytes, "application/pdf", $"FGO_{fgo.ID_FGO}_{DateTime.Now:yyyyMMdd}.pdf");
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при экспорте деталей ФГО в PDF для ID {Id}", id);
                TempData["ErrorMessage"] = $"Ошибка при экспорте в PDF: {ex.Message}";
                return RedirectToAction("DetailsPhysicalGeo", new { id });
            }
        }

        [HttpGet]
        [Route("Catalog/Railway/ExportPdf/{id:int}")]
        public IActionResult ExportRailwayDetailsToPdf(int id)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                
                var railway = connection.QueryFirstOrDefault<RailwayObject>(
                    $@"SELECT
                        r.""id_rw"" as ID_RW, r.namerus as NAMERUS, r.namebel as NAMEBEL, r.namelat as NAMELAT, r.namenorm as NAMENORM, r.ecp as ECP, r.nomenklat as NOMENKLAT,
                        r.x_wgs as Latitude, r.y_wgs as Longitude, r.datereg::timestamp as DATEREG, r.existence as EXISTENCE,
                        r.geopr as LocationDescription, r.udarrus as UDARRUS, r.udarbel as UDARBEL, o.obl as RegionName,
                        ra.ra as DistrictName, c.nkod as CategoryName, n.nod as NodeName
                    FROM kn_dbrw r
                    LEFT JOIN kn_obl o ON r.obl = o.id_obl
                    LEFT JOIN kn_ra ra ON r.ra = ra.id_ra
                    LEFT JOIN kn_category c ON r.category = c.id_categor
                    LEFT JOIN kn_nod n ON r.nods = n.id_nod
                    WHERE r.""id_rw"" = @Id",
                    new { Id = id });
                
                if (railway == null)
                {
                    TempData["ErrorMessage"] = "Железнодорожный объект для экспорта не найден.";
                    return RedirectToAction("Index");
                }
                
                var changeHistory = connection.Query(
                    @"SELECT redate as ChangeDate, changes as ChangeDescription, namedoc as DocumentName
                    FROM kn_hchangerw WHERE id_rw = @Id ORDER BY redate DESC",
                    new { Id = id }).ToList();
                
                string fontPath = Path.Combine(_hostingEnvironment.WebRootPath, "fonts", "tahoma.ttf");
                BaseFont baseFont = BaseFont.CreateFont(fontPath, BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                Font titleFont = new Font(baseFont, 16, Font.BOLD);
                Font headerFont = new Font(baseFont, 12, Font.BOLD);
                Font regularFont = new Font(baseFont, 10, Font.NORMAL);
                Font boldFont = new Font(baseFont, 10, Font.BOLD);
                
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    Document document = new Document(PageSize.A4, 40, 40, 40, 40);
                    PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);
                    document.Open();
                    
                    var title = new Paragraph($"Паспорт объекта: {railway.NAMERUS}", titleFont)
                    {
                        Alignment = Element.ALIGN_CENTER,
                        SpacingAfter = 20
                    };
                    document.Add(title);
                    
                    document.Add(new Paragraph("Общая информация", headerFont) { SpacingAfter = 10 });
                    
                    var mainInfoTable = new PdfPTable(2) { WidthPercentage = 100, SpacingAfter = 20 };
                    mainInfoTable.SetWidths(new float[] { 1f, 2f });
                    
                    Action<string, string> AddRow = (key, value) =>
                    {
                        mainInfoTable.AddCell(new Phrase(key, boldFont));
                        mainInfoTable.AddCell(new Phrase(value ?? "Нет данных", regularFont));
                    };
                    
                    AddRow("Название (бел.)", railway.NAMEBEL);
                    AddRow("Категория", railway.CategoryName);
                    AddRow("Статус", railway.EXISTENCE);
                    AddRow("Область", railway.RegionName);
                    AddRow("Район", railway.DistrictName);
                    AddRow("Узел", railway.NodeName);
                    AddRow("Код ЕСР", railway.ECP?.ToString());
                    AddRow("Дата регистрации", railway.DATEREG?.ToString("dd.MM.yyyy") ?? "Нет данных");
                    AddRow("Координаты (WGS-84)", railway.Latitude.HasValue ? $"{railway.Latitude:F6}, {railway.Longitude:F6}" : "Не указаны");
                    AddRow("Геопривязка", railway.LocationDescription);
                    AddRow("Нормализованное название", railway.NAMENORM);
                    
                    document.Add(mainInfoTable);
                    
                    if (changeHistory.Any())
                    {
                        document.Add(new Paragraph("История изменений", headerFont) { SpacingAfter = 10 });
                        var historyTable = new PdfPTable(2) { WidthPercentage = 100 };
                        historyTable.SetWidths(new float[] { 1f, 4f });
                        historyTable.AddCell(new Phrase("Дата", boldFont));
                        historyTable.AddCell(new Phrase("Описание", boldFont));
                        foreach (var record in changeHistory)
                        {
                            historyTable.AddCell(new Phrase(record.ChangeDate?.ToString() ?? "", regularFont));
                            historyTable.AddCell(new Phrase(record.ChangeDescription ?? "", regularFont));
                        }
                        document.Add(historyTable);
                    }
                    
                    document.Close();
                    writer.Close();
                    
                    var bytes = memoryStream.ToArray();
                    return File(bytes, "application/pdf", $"Railway_{railway.ID_RW}_{DateTime.Now:yyyyMMdd}.pdf");
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при экспорте деталей ж/д объекта в PDF для ID {Id}", id);
                TempData["ErrorMessage"] = $"Ошибка при экспорте в PDF: {ex.Message}";
                return RedirectToAction("DetailsRailway", new { id });
            }
        }

        #region Helper Methods
        private static int? ToIntNull(object o)
        {
            if (o == null || o is DBNull) return null;
            if (o is int i) return i;
            if (o is long l) return (int)l;
            if (o is double d) return (int)d;
            if (o is decimal dec) return (int)dec;
            if (o is string s)
            {
                if (int.TryParse(s, out var iv)) return iv;
                if (double.TryParse(s, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out var dv))
                    return (int)dv;
            }
            return (int)Convert.ToDouble(o);
        }
        #endregion
    }
}