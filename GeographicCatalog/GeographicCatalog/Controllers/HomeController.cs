using Microsoft.AspNetCore.Mvc;
using Dapper;
using Npgsql;
using GeographicCatalog.Models;
using System.Diagnostics;

namespace GeographicCatalog.Controllers
{
    public class HomeController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<HomeController> _logger;

        public HomeController(IConfiguration configuration, ILogger<HomeController> logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        public IActionResult Index()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                connection.Open();

                // --- Статистика по типам объектов (с учётом реальной структуры БД) ---
                ViewBag.TotalSettlements = connection.ExecuteScalar<int>(
                    "SELECT COUNT(*) FROM kn_dbate WHERE existence = 'существует' OR existence IS NULL");
                ViewBag.TotalAirports = connection.ExecuteScalar<int>(
                    "SELECT COUNT(*) FROM kn_dbair");
                ViewBag.TotalRailway = connection.ExecuteScalar<int>(
                    "SELECT COUNT(*) FROM kn_dbrw WHERE existence = 'существует' OR existence IS NULL");
                ViewBag.TotalFGO = connection.ExecuteScalar<int>(
                    "SELECT COUNT(*) FROM kn_dbfgo WHERE existence = 'существует' OR existence IS NULL");

                // --- Типы населённых пунктов ---
                ViewBag.SettlementTypes = connection.Query(
                    @"SELECT 
                        r.ratename AS Type, 
                        COUNT(*) AS Count
                      FROM kn_dbate b
                      INNER JOIN kn_rodate r ON b.id_rodate = r.id_rodate
                      WHERE b.existence = 'существует' OR b.existence IS NULL
                      GROUP BY r.ratename 
                      ORDER BY Count DESC").ToList();

                // --- Последние добавленные объекты (1 месяц) ---
                ViewBag.RecentObjects = connection.Query(
                    @"SELECT 
                        ObjectType,
                        NameRu as Name,
                        TypeName,
                        RegionName,
                        CreatedDate
                      FROM (
                        SELECT 'ATE' as ObjectType, b.namerus as NameRu, 
                               rt.ratename as TypeName,
                               o.obl as RegionName,
                               b.""daterЕg"" as CreatedDate
                        FROM kn_dbate b
                        LEFT JOIN kn_obl o ON b.id_obl = o.id_obl
                        LEFT JOIN kn_rodate rt ON b.id_rodate = rt.id_rodate
                        WHERE (b.existence = 'существует' OR b.existence IS NULL)
                        UNION ALL
                        SELECT 'AIR' as ObjectType, a.namerus as NameRu, a.category as TypeName,
                               o.obl as RegionName,
                               a.datereg as CreatedDate
                        FROM kn_dbair a
                        LEFT JOIN kn_obl o ON a.obl = o.id_obl
                        UNION ALL
                        SELECT 'RW' as ObjectType, r.namerus as NameRu, 
                               c.nkod as TypeName,
                               o.obl as RegionName,
                               r.datereg as CreatedDate
                        FROM kn_dbrw r
                        LEFT JOIN kn_obl o ON r.obl = o.id_obl
                        LEFT JOIN kn_category c ON r.category = c.id_categor
                        WHERE (r.existence = 'существует' OR r.existence IS NULL)
                        UNION ALL
                        SELECT 'FGO' as ObjectType, f.namerus as NameRu,
                               rf.rfgoname as TypeName,
                               o.obl as RegionName,
                               f.datereg as CreatedDate
                        FROM kn_dbfgo f
                        LEFT JOIN kn_obl o ON f.obl = o.id_obl
                        LEFT JOIN kn_rodfgo rf ON f.rodfgo = rf.id_rodfgo
                        WHERE (f.existence = 'существует' OR f.existence IS NULL)
                      ) as AllObjects
                      WHERE CreatedDate IS NOT NULL 
                      ORDER BY CreatedDate DESC
                      LIMIT 10").ToList();

                // --- Статистика по областям ---
                ViewBag.RegionStats = connection.Query(
                    @"SELECT 
                        o.obl AS Region, 
                        COUNT(b.kod_ate) AS SettlementCount
                      FROM kn_obl o
                      LEFT JOIN kn_dbate b ON o.id_obl = b.id_obl 
                          AND (b.existence = 'существует' OR b.existence IS NULL)
                      GROUP BY o.obl
                      ORDER BY o.obl").ToList();

                // --- Крупнейшие населённые пункты ---
                ViewBag.LargestSettlements = connection.Query(
                    @"SELECT
                        p.kod_ate as Id,
                        a.namerus as Name,
                        p.popular as Population,
                        o.obl as RegionName,
                        r.ratename as CategoryName
                    FROM kn_hpopular p
                    JOIN kn_dbate a ON p.kod_ate = a.kod_ate
                    LEFT JOIN kn_obl o ON a.id_obl = o.id_obl
                    LEFT JOIN kn_rodate r ON a.id_rodate = r.id_rodate
                    WHERE (a.existence = 'существует' OR a.existence IS NULL) 
                          AND p.popular IS NOT NULL
                    ORDER BY p.popular DESC
                    LIMIT 10").ToList();

                return View();
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка на главной странице");
                ViewBag.ErrorMessage = $"Ошибка подключения к базе данных: {ex.Message}";
                return View();
            }
        }

        [HttpGet]
        public IActionResult GetQuickStats()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                var stats = new
                {
                    Settlements = connection.ExecuteScalar<int>(
                        "SELECT COUNT(*) FROM kn_dbate WHERE existence = 'существует' OR existence IS NULL"),
                    Airports = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbair"),
                    Railway = connection.ExecuteScalar<int>(
                        "SELECT COUNT(*) FROM kn_dbrw WHERE existence = 'существует' OR existence IS NULL"),
                    GeoObjects = connection.ExecuteScalar<int>(
                        "SELECT COUNT(*) FROM kn_dbfgo WHERE existence = 'существует' OR existence IS NULL"),
                    TotalObjects = connection.ExecuteScalar<int>(
                        @"SELECT 
                            (SELECT COUNT(*) FROM kn_dbate WHERE existence = 'существует' OR existence IS NULL) +
                            (SELECT COUNT(*) FROM kn_dbair) +
                            (SELECT COUNT(*) FROM kn_dbrw WHERE existence = 'существует' OR existence IS NULL) +
                            (SELECT COUNT(*) FROM kn_dbfgo WHERE existence = 'существует' OR existence IS NULL)"),
                    LastUpdate = connection.ExecuteScalar<DateTime?>(@"
                        SELECT MAX(LastDate) 
                        FROM (
                            SELECT MAX(""daterЕg""::timestamp) as LastDate FROM kn_dbate
                            UNION ALL
                            SELECT MAX(datereg::timestamp) as LastDate FROM kn_dbair
                            UNION ALL
                            SELECT MAX(datereg::timestamp) as LastDate FROM kn_dbrw
                            UNION ALL
                            SELECT MAX(datereg::timestamp) as LastDate FROM kn_dbfgo
                        ) as Dates") ?? DateTime.Now
                };

                return Json(new { success = true, data = stats });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении быстрой статистики");
                return Json(new { success = false, error = ex.Message });
            }
        }

        [HttpGet]
        public IActionResult GetMapData(string type = null, int? regionId = null)
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                // --- Оптимизированный запрос с CTE ---
                var query = @"
                    WITH AllObjects AS (
                        SELECT 
                            'ATE' as ObjectType,
                            b.kod_ate as ObjectId,
                            b.namerus as NameRu,
                            b.namebel as NameBe,
                            rt.ratename as TypeName,
                            b.x_wgs as Latitude,
                            b.y_wgs as Longitude,
                            o.obl as RegionName,
                            b.id_obl as RegionId
                        FROM kn_dbate b
                        LEFT JOIN kn_obl o ON b.id_obl = o.id_obl
                        LEFT JOIN kn_rodate rt ON b.id_rodate = rt.id_rodate
                        WHERE (b.existence = 'существует' OR b.existence IS NULL) 
                              AND b.y_wgs IS NOT NULL AND b.x_wgs IS NOT NULL

                        UNION ALL

                        SELECT 
                            'AIR' as ObjectType,
                            a.id_air as ObjectId,
                            a.namerus as NameRu,
                            a.namebel as NameBe,
                            a.category as TypeName,
                            a.x_wgs as Latitude,
                            a.y_wgs as Longitude,
                            o.obl as RegionName,
                            a.obl as RegionId
                        FROM kn_dbair a
                        LEFT JOIN kn_obl o ON a.obl = o.id_obl
                        WHERE a.y_wgs IS NOT NULL AND a.x_wgs IS NOT NULL

                        UNION ALL

                        SELECT 
                            'RW' as ObjectType,
                            r.id_rw as ObjectId,
                            r.namerus as NameRu,
                            r.namebel as NameBe,
                            c.nkod as TypeName,
                            r.x_wgs as Latitude,
                            r.y_wgs as Longitude,
                            o.obl as RegionName,
                            r.obl as RegionId
                        FROM kn_dbrw r
                        LEFT JOIN kn_obl o ON r.obl = o.id_obl
                        LEFT JOIN kn_category c ON r.category = c.id_categor
                        WHERE (r.existence = 'существует' OR r.existence IS NULL) 
                              AND r.y_wgs IS NOT NULL AND r.x_wgs IS NOT NULL

                        UNION ALL

                        SELECT 
                            'FGO' as ObjectType,
                            f.id_fgo as ObjectId,
                            f.namerus as NameRu,
                            f.namebel as NameBe,
                            rf.rfgoname as TypeName,
                            f.x_wgs as Latitude,
                            f.y_wgs as Longitude,
                            o.obl as RegionName,
                            f.obl as RegionId
                        FROM kn_dbfgo f
                        LEFT JOIN kn_obl o ON f.obl = o.id_obl
                        LEFT JOIN kn_rodfgo rf ON f.rodfgo = rf.id_rodfgo
                        WHERE (f.existence = 'существует' OR f.existence IS NULL) 
                              AND f.y_wgs IS NOT NULL AND f.x_wgs IS NOT NULL
                    )
                    SELECT * FROM AllObjects WHERE 1=1";

                var parameters = new DynamicParameters();

                if (!string.IsNullOrEmpty(type))
                {
                    query += " AND ObjectType = @Type";
                    parameters.Add("@Type", type);
                }

                if (regionId.HasValue)
                {
                    query += " AND RegionId = @RegionId";
                    parameters.Add("@RegionId", regionId.Value);
                }

                query += " ORDER BY NameRu";

                var data = connection.Query(query, parameters).ToList();

                return Json(new { success = true, data, count = data.Count });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении данных для карты");
                return Json(new { success = false, error = ex.Message });
            }
        }

        public IActionResult About()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                ViewBag.DbInfo = new
                {
                    Version = connection.ExecuteScalar<string>("SELECT version()"),
                    Name = connection.Database,
                    Server = (connection as NpgsqlConnection)?.Host ?? connection.DataSource,
                    LastUpdate = connection.ExecuteScalar<DateTime?>(@"
                        SELECT MAX(LastDate) 
                        FROM (
                            SELECT MAX(""daterЕg""::timestamp) as LastDate FROM kn_dbate
                            UNION ALL
                            SELECT MAX(datereg::timestamp) as LastDate FROM kn_dbair
                            UNION ALL
                            SELECT MAX(datereg::timestamp) as LastDate FROM kn_dbrw
                            UNION ALL
                            SELECT MAX(datereg::timestamp) as LastDate FROM kn_dbfgo
                        ) as Dates")
                };

                ViewBag.RegistrationStats = connection.Query(
                    @"SELECT 
                        EXTRACT(YEAR FROM ""daterЕg""::timestamp)::int as Year,
                        COUNT(*) as Count
                      FROM kn_dbate 
                      WHERE ""daterЕg"" IS NOT NULL
                      GROUP BY EXTRACT(YEAR FROM ""daterЕg""::timestamp)
                      ORDER BY Year DESC").ToList();

                return View();
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка на странице О проекте");
                ViewBag.DbInfo = new { Version = "Информация недоступна" };
                return View();
            }
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            var errorModel = new ErrorViewModel
            {
                RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier,
                Message = HttpContext.Items["ErrorMessage"]?.ToString()
            };

            _logger?.LogError("Ошибка на странице. RequestId: {RequestId}, Message: {Message}",
                errorModel.RequestId, errorModel.Message);

            return View(errorModel);
        }

        // --- НОВОЕ: API для получения сводной статистики ---
        [HttpGet]
        [Route("api/home/dashboard")]
        public IActionResult GetDashboardData()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));

                var dashboardData = new
                {
                    totalObjects = connection.ExecuteScalar<int>(
                        @"SELECT 
                            (SELECT COUNT(*) FROM kn_dbate WHERE existence = 'существует' OR existence IS NULL) +
                            (SELECT COUNT(*) FROM kn_dbair) +
                            (SELECT COUNT(*) FROM kn_dbrw WHERE existence = 'существует' OR existence IS NULL) +
                            (SELECT COUNT(*) FROM kn_dbfgo WHERE existence = 'существует' OR existence IS NULL)"),
                    byType = new
                    {
                        settlements = connection.ExecuteScalar<int>(
                            "SELECT COUNT(*) FROM kn_dbate WHERE existence = 'существует' OR existence IS NULL"),
                        airports = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbair"),
                        railway = connection.ExecuteScalar<int>(
                            "SELECT COUNT(*) FROM kn_dbrw WHERE existence = 'существует' OR existence IS NULL"),
                        geoObjects = connection.ExecuteScalar<int>(
                            "SELECT COUNT(*) FROM kn_dbfgo WHERE existence = 'существует' OR existence IS NULL")
                    },
                    byRegion = connection.Query(
                        @"SELECT o.obl as name, COUNT(b.kod_ate) as value
                          FROM kn_obl o
                          LEFT JOIN kn_dbate b ON o.id_obl = b.id_obl 
                              AND (b.existence = 'существует' OR b.existence IS NULL)
                          GROUP BY o.obl
                          ORDER BY value DESC
                          LIMIT 5").ToList(),
                    recentCount = connection.ExecuteScalar<int>(
                        @"SELECT COUNT(*) FROM (
                            SELECT datereg FROM kn_dbair WHERE datereg >= CURRENT_DATE - INTERVAL '30 days'
                            UNION ALL
                            SELECT datereg FROM kn_dbrw WHERE datereg >= CURRENT_DATE - INTERVAL '30 days'
                            UNION ALL
                            SELECT datereg FROM kn_dbfgo WHERE datereg >= CURRENT_DATE - INTERVAL '30 days'
                        ) as Recent")
                };

                return Json(new { success = true, data = dashboardData });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении данных для дашборда");
                return Json(new { success = false, error = ex.Message });
            }
        }

        // --- НОВОЕ: Проверка здоровья базы данных ---
        [HttpGet]
        [Route("api/home/health")]
        public IActionResult HealthCheck()
        {
            try
            {
                using var connection = new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
                connection.Open();

                var tables = new[] { "kn_dbate", "kn_dbair", "kn_dbrw", "kn_dbfgo" };
                var tableStatus = new List<object>();

                foreach (var table in tables)
                {
                    var count = connection.ExecuteScalar<int>($"SELECT COUNT(*) FROM {table}");
                    tableStatus.Add(new { table, count, status = count > 0 ? "OK" : "Empty" });
                }

                return Json(new
                {
                    success = true,
                    database = "Connected",
                    tables = tableStatus,
                    timestamp = DateTime.Now
                });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при проверке здоровья БД");
                return Json(new
                {
                    success = false,
                    database = "Disconnected",
                    error = ex.Message,
                    timestamp = DateTime.Now
                });
            }
        }
    }

    public class ErrorViewModel
    {
        public string RequestId { get; set; }
        public string Message { get; set; }
        public bool ShowRequestId => !string.IsNullOrEmpty(RequestId);
    }
}