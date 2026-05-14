// GeographicCatalog/Controllers/AdminController.cs
using Dapper;
using GeographicCatalog.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Npgsql;
using System.Diagnostics;
using System.Globalization;

namespace GeographicCatalog.Controllers
{
    [Authorize]
    public class AdminController : Controller
    {
        private readonly IConfiguration _configuration;
        private readonly ILogger<AdminController> _logger;
        private const int PageSize = 25;
        
        // ВАЖНО: Кириллическая Е в имени колонки daterЕg для kn_dbate (согласно схеме)
        private const string AteDateColumn = "daterЕg";

        public AdminController(IConfiguration configuration, ILogger<AdminController> logger)
        {
            _configuration = configuration;
            _logger = logger;
        }

        #region Helper Methods
        private static int? ToIntNull(object o)
        {
            if (o == null || o is DBNull) return null;
            if (o is int i) return i;
            if (o is long l) return (int)l;
            if (o is double d) return (int)d;
            if (o is decimal dec) return (int)dec;
            if (o is string s && int.TryParse(s, out var result)) return result;
            return (int)Convert.ToDouble(o);
        }

        private static int ToInt(object o)
        {
            if (o == null || o is DBNull) return 0;
            if (o is int i) return i;
            if (o is long l) return (int)l;
            if (o is double d) return (int)d;
            return (int)Convert.ToDouble(o);
        }

        private static double? ToDoubleNull(object o)
        {
            if (o == null || o is DBNull) return null;
            if (o is double d) return d;
            if (o is float f) return f;
            if (o is int i) return i;
            return Convert.ToDouble(o);
        }

        private static long? ToLongNull(object o)
        {
            if (o == null || o is DBNull) return null;
            if (o is long l) return l;
            if (o is int i) return i;
            if (o is double d) return (long)d;
            if (o is float f) return (long)f;
            if (o is decimal dec) return (long)dec;
            if (o is string s)
            {
                if (long.TryParse(s, out var lv)) return lv;
                if (double.TryParse(s, System.Globalization.NumberStyles.Float, 
                    System.Globalization.CultureInfo.InvariantCulture, out var dv))
                    return (long)dv;
            }
            return (long)Convert.ToDouble(o);
        }

        private NpgsqlConnection CreateConnection()
        {
            return new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }

        // Генерация СОАТО на основе id области и id района
        private long? GenerateSoatoCode(NpgsqlConnection connection, int? regionId, int? districtId, string sovet = null)
        {
            try
            {
                string regionCode = "00";
                if (regionId.HasValue && regionId.Value > 0)
                {
                    regionCode = regionId.Value.ToString("D2");
                }

                string districtCode = "00";
                if (districtId.HasValue && districtId.Value > 0)
                {
                    districtCode = districtId.Value.ToString("D2");
                }

                string sovetCode = "00";
                if (!string.IsNullOrWhiteSpace(sovet))
                {
                    sovetCode = sovet.PadLeft(2, '0').Substring(0, 2);
                }

                string prefix = regionCode + districtCode + sovetCode;
                var maxSettlementCode = connection.ExecuteScalar<int?>(
                    @"SELECT COALESCE(MAX(RIGHT(soato, 3)::int), 0)
                      FROM kn_dbate
                      WHERE LEFT(soato, 6) = @Prefix AND soato IS NOT NULL",
                    new { Prefix = prefix });

                string settlementCode = (maxSettlementCode.Value + 1).ToString("D3");
                string fullSoato = regionCode + districtCode + sovetCode + settlementCode;

                if (long.TryParse(fullSoato, out var soatoValue))
                {
                    _logger?.LogInformation(
                        "Сгенерирован СОАТО: {Soato} (RegionId={RegionId}, DistrictId={DistrictId})",
                        soatoValue, regionId, districtId);
                    return soatoValue;
                }
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при генерации кода СОАТО");
            }

            var nextSoato = connection.ExecuteScalar<long>(
                "SELECT COALESCE(MAX(soato::numeric), 0) + 1 FROM kn_dbate WHERE soato IS NOT NULL");
            return nextSoato;
        }
        #endregion

        #region Dashboard
        [HttpGet]
        public IActionResult Index()
        {
            try
            {
                using var connection = CreateConnection();
                var stats = GetStatistics(connection);
                ViewBag.Statistics = stats;
                return View(stats);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка на странице админ-панели");
                TempData["ErrorMessage"] = ex.Message;
                return View(new AdminDashboardViewModel());
            }
        }

        private AdminDashboardViewModel GetStatistics(NpgsqlConnection connection)
        {
            return new AdminDashboardViewModel
            {
                AteCount = connection.ExecuteScalar<int>(
                    "SELECT COUNT(*) FROM kn_dbate WHERE existence = 'существует' OR existence IS NULL"),
                AirportsCount = connection.ExecuteScalar<int>("SELECT COUNT(*) FROM kn_dbair"),
                RailwayCount = connection.ExecuteScalar<int>(
                    "SELECT COUNT(*) FROM kn_dbrw WHERE existence = 'существует' OR existence IS NULL"),
                FgoCount = connection.ExecuteScalar<int>(
                    "SELECT COUNT(*) FROM kn_dbfgo WHERE existence = 'существует' OR existence IS NULL")
            };
        }
        #endregion

        #region List Actions
        [HttpGet]
        [Route("Admin/ATE")]
        public IActionResult ListAte(int page = 1, string search = null, int? regionId = null, int? districtId = null, string sortBy = null)
        {
            return ListEntities("ATE", "Населенные пункты", page, search, regionId, districtId, sortBy);
        }

        [HttpGet]
        [Route("Admin/Airports")]
        public IActionResult ListAirports(int page = 1, string search = null, int? regionId = null, int? districtId = null, string sortBy = null)
        {
            return ListEntities("AIR", "Аэропорты", page, search, regionId, districtId, sortBy);
        }

        [HttpGet]
        [Route("Admin/Railway")]
        public IActionResult ListRailway(int page = 1, string search = null, int? regionId = null, int? districtId = null, string sortBy = null)
        {
            Console.WriteLine(regionId);
            Console.WriteLine(districtId);
            Console.WriteLine(sortBy);
            Console.WriteLine(search);
            Console.WriteLine(page);
            return ListEntities("RW", "Железнодорожные объекты", page, search, regionId, districtId, sortBy);
        }

        [HttpGet]
        [Route("Admin/FGO")]
        public IActionResult ListFgo(int page = 1, string search = null, int? regionId = null, int? districtId = null, string sortBy = null)
        {
            return ListEntities("FGO", "Физ.-геогр. объекты", page, search, regionId, districtId, sortBy);
        }

        private IActionResult ListEntities(string objectType, string title, int page, string search, int? regionId, int? districtId, string sortBy)
        {
            try
            {
                using var connection = CreateConnection();
                
                // Сначала загружаем справочники для dropdown'ов
                LoadListDropdowns(connection, regionId);
                
                var (items, totalCount) = objectType switch
                {
                    "ATE" => GetAtePage(connection, page, search, regionId, districtId, sortBy),
                    "AIR" => GetAirportsPage(connection, page, search, regionId, districtId, sortBy),
                    "RW" => GetRailwayPage(connection, page, search, regionId, districtId, sortBy),
                    "FGO" => GetFgoPage(connection, page, search, regionId, districtId, sortBy),
                    _ => (new List<AdminListEntry>(), 0)
                };

                var totalPages = PageSize > 0 ? (int)Math.Ceiling((double)totalCount / PageSize) : 0;
                
                var model = new AdminListViewModel
                {
                    ObjectType = objectType,
                    Title = title,
                    Items = items,
                    Page = page,
                    TotalCount = totalCount,
                    PageSize = PageSize,
                    TotalPages = totalPages,
                    Search = search,
                    RegionId = regionId,
                    DistrictId = districtId,
                    SortBy = sortBy
                };

                // Сохраняем все параметры фильтрации для View
                ViewBag.RegionId = regionId;
                ViewBag.DistrictId = districtId;
                ViewBag.Search = search;
                ViewBag.SortBy = sortBy;
                ViewBag.CurrentObjectType = objectType;

                return View("List", model);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при загрузке списка {Type}", objectType);
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction("Index");
            }
        }
        #endregion

        #region Get Page Methods
        private (List<AdminListEntry> items, int total) GetAtePage(NpgsqlConnection connection, int page, string search, int? regionId, int? districtId, string sortBy)
        {
            var where = new List<string> { "(b.existence = 'существует' OR b.existence IS NULL)" };
            var parameters = new DynamicParameters();

            if (!string.IsNullOrWhiteSpace(search))
            {
                where.Add("(b.namerus LIKE @Search OR b.namebel LIKE @Search)");
                parameters.Add("Search", $"%{search.Trim()}%");
            }

            // Проверка на null и > 0 для числовых полей
            if (regionId.HasValue && regionId.Value > 0)
            {
                where.Add("b.id_obl = @RegionId");
                parameters.Add("RegionId", regionId.Value);
            }

            if (districtId.HasValue && districtId.Value > 0)
            {
                where.Add("b.id_ra = @DistrictId");
                parameters.Add("DistrictId", districtId.Value);
            }

            // ✅ ИСПРАВЛЕНО: WHERE добавляется только если есть условия
            var whereSql = where.Count > 0 ? " WHERE " + string.Join(" AND ", where) : "";
            
            var countSql = "SELECT COUNT(*) FROM kn_dbate b" + whereSql;
            var total = connection.ExecuteScalar<int>(countSql, parameters);

            string orderBy = sortBy switch
            {
                "name_desc" => "b.namerus DESC",
                "id_asc" => "b.kod_ate ASC",
                "id_desc" => "b.kod_ate DESC",
                _ => "b.namerus ASC"
            };

            var sql = $@"
                SELECT b.kod_ate AS Id, b.namerus AS NameRu, b.namebel AS NameBe,
                       o.obl AS RegionName, r.ra AS DistrictName, b.existence AS StatusName
                FROM kn_dbate b
                LEFT JOIN kn_obl o ON b.id_obl = o.id_obl
                LEFT JOIN kn_ra r ON b.id_ra = r.id_ra
                {whereSql}
                ORDER BY {orderBy}
                OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            parameters.Add("Offset", (page - 1) * PageSize);
            parameters.Add("PageSize", PageSize);

            var rows = connection.Query<dynamic>(sql, parameters).ToList();
            
            var list = rows.Select(r => new AdminListEntry
            {
                Id = ToIntNull(r.id) ?? 0,
                NameRu = r.nameru?.ToString() ?? "",
                NameBe = r.namebe?.ToString() ?? "",
                RegionName = r.regionname?.ToString() ?? "",
                DistrictName = r.districtname?.ToString() ?? "",
                StatusName = r.statusname?.ToString() ?? ""
            }).ToList();

            return (list, total);
        }

        private (List<AdminListEntry> items, int total) GetAirportsPage(NpgsqlConnection connection, int page, string search, int? regionId, int? districtId, string sortBy)
        {
            var where = new List<string>();
            var parameters = new DynamicParameters();

            if (!string.IsNullOrWhiteSpace(search))
            {
                where.Add("(a.namerus LIKE @Search OR a.namebel LIKE @Search)");
                parameters.Add("Search", $"%{search.Trim()}%");
            }

            if (regionId.HasValue && regionId.Value > 0)
            {
                where.Add("a.obl = @RegionId");
                parameters.Add("RegionId", regionId.Value);
            }

            if (districtId.HasValue && districtId.Value > 0)
            {
                where.Add("a.ra = @DistrictId");
                parameters.Add("DistrictId", districtId.Value);
            }

            var whereSql = where.Count > 0 ? " WHERE " + string.Join(" AND ", where) : "";
            
            var countSql = "SELECT COUNT(*) FROM kn_dbair a" + whereSql;
            var total = connection.ExecuteScalar<int>(countSql, parameters);

            string orderBy = sortBy switch
            {
                "name_desc" => "a.namerus DESC",
                "id_asc" => "a.id_air ASC",
                "id_desc" => "a.id_air DESC",
                _ => "a.namerus ASC"
            };

            var sql = $@"
                SELECT a.id_air AS Id, a.namerus AS NameRu, a.namebel AS NameBe,
                       o.obl AS RegionName, r.ra AS DistrictName, a.category AS StatusName
                FROM kn_dbair a
                LEFT JOIN kn_obl o ON a.obl = o.id_obl
                LEFT JOIN kn_ra r ON a.ra = r.id_ra
                {whereSql}
                ORDER BY {orderBy}
                OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            parameters.Add("Offset", (page - 1) * PageSize);
            parameters.Add("PageSize", PageSize);

            var rows = connection.Query<dynamic>(sql, parameters).ToList();
            
            var list = rows.Select(r => new AdminListEntry
            {
                Id = ToIntNull(r.id) ?? 0,
                NameRu = r.nameru?.ToString() ?? "",
                NameBe = r.namebe?.ToString() ?? "",
                RegionName = r.regionname?.ToString() ?? "",
                DistrictName = r.districtname?.ToString() ?? "",
                StatusName = r.statusname?.ToString() ?? ""
            }).ToList();

            return (list, total);
        }

        private (List<AdminListEntry> items, int total) GetRailwayPage(NpgsqlConnection connection, int page, string search, int? regionId, int? districtId, string sortBy)
        {
            var where = new List<string> { "(rw.existence = 'существует' OR rw.existence IS NULL)" };
            var parameters = new DynamicParameters();

            if (!string.IsNullOrWhiteSpace(search))
            {
                where.Add("(rw.namerus LIKE @Search OR rw.namebel LIKE @Search)");
                parameters.Add("Search", $"%{search.Trim()}%");
            }

            if (regionId.HasValue && regionId.Value > 0)
            {
                where.Add("rw.obl = @RegionId");
                parameters.Add("RegionId", regionId.Value);
            }

            if (districtId.HasValue && districtId.Value > 0)
            {
                where.Add("rw.ra = @DistrictId");
                parameters.Add("DistrictId", districtId.Value);
            }

            var whereSql = where.Count > 0 ? " WHERE " + string.Join(" AND ", where) : "";
            
            var countSql = "SELECT COUNT(*) FROM kn_dbrw rw" + whereSql;
            var total = connection.ExecuteScalar<int>(countSql, parameters);

            string orderBy = sortBy switch
            {
                "name_desc" => "rw.namerus DESC",
                "id_asc" => "rw.id_rw ASC",
                "id_desc" => "rw.id_rw DESC",
                _ => "rw.namerus ASC"
            };

            var sql = $@"
                SELECT rw.id_rw AS Id, rw.namerus AS NameRu, rw.namebel AS NameBe,
                       o.obl AS RegionName, ra.ra AS DistrictName, rw.existence AS StatusName
                FROM kn_dbrw rw
                LEFT JOIN kn_obl o ON rw.obl = o.id_obl
                LEFT JOIN kn_ra ra ON rw.ra = ra.id_ra
                {whereSql}
                ORDER BY {orderBy}
                OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            parameters.Add("Offset", (page - 1) * PageSize);
            parameters.Add("PageSize", PageSize);

            Console.WriteLine(sql);

            var rows = connection.Query<dynamic>(sql, parameters).ToList();
            
            var list = rows.Select(r => new AdminListEntry
            {
                Id = ToIntNull(r.id) ?? 0,
                NameRu = r.nameru?.ToString() ?? "",
                NameBe = r.namebe?.ToString() ?? "",
                RegionName = r.regionname?.ToString() ?? "",
                DistrictName = r.districtname?.ToString() ?? "",
                StatusName = r.statusname?.ToString() ?? ""
            }).ToList();

            return (list, total);
        }

        private (List<AdminListEntry> items, int total) GetFgoPage(NpgsqlConnection connection, int page, string search, int? regionId, int? districtId, string sortBy)
        {
            var where = new List<string> { "(f.existence = 'существует' OR f.existence IS NULL)" };
            var parameters = new DynamicParameters();

            if (!string.IsNullOrWhiteSpace(search))
            {
                where.Add("(f.namerus LIKE @Search OR f.namebel LIKE @Search)");
                parameters.Add("Search", $"%{search.Trim()}%");
            }

            if (regionId.HasValue && regionId.Value > 0)
            {
                where.Add("f.obl = @RegionId");
                parameters.Add("RegionId", regionId.Value);
            }

            if (districtId.HasValue && districtId.Value > 0)
            {
                where.Add("f.ra = @DistrictId");
                parameters.Add("DistrictId", districtId.Value);
            }

            var whereSql = where.Count > 0 ? " WHERE " + string.Join(" AND ", where) : "";
            
            var countSql = "SELECT COUNT(*) FROM kn_dbfgo f" + whereSql;
            var total = connection.ExecuteScalar<int>(countSql, parameters);

            string orderBy = sortBy switch
            {
                "name_desc" => "f.namerus DESC",
                "id_asc" => "f.id_fgo ASC",
                "id_desc" => "f.id_fgo DESC",
                _ => "f.namerus ASC"
            };

            var sql = $@"
                SELECT f.id_fgo AS Id, f.namerus AS NameRu, f.namebel AS NameBe,
                       o.obl AS RegionName, r.ra AS DistrictName, f.existence AS StatusName
                FROM kn_dbfgo f
                LEFT JOIN kn_obl o ON f.obl = o.id_obl
                LEFT JOIN kn_ra r ON f.ra = r.id_ra
                {whereSql}
                ORDER BY {orderBy}
                OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY";

            parameters.Add("Offset", (page - 1) * PageSize);
            parameters.Add("PageSize", PageSize);

            var rows = connection.Query<dynamic>(sql, parameters).ToList();
            
            var list = rows.Select(r => new AdminListEntry
            {
                Id = ToIntNull(r.id) ?? 0,
                NameRu = r.nameru?.ToString() ?? "",
                NameBe = r.namebe?.ToString() ?? "",
                RegionName = r.regionname?.ToString() ?? "",
                DistrictName = r.districtname?.ToString() ?? "",
                StatusName = r.statusname?.ToString() ?? ""
            }).ToList();

            return (list, total);
        }
        #endregion

        #region Edit/Create Actions - ATE
        [HttpGet]
        [Route("Admin/ATE/Edit/{id:int}")]
        public IActionResult EditAte(int id)
        {
            try
            {
                using var connection = CreateConnection();
                var row = connection.QueryFirstOrDefault<dynamic>(
                    $@"SELECT kod_ate AS Id, namerus, namebel, namelat, udarrus, udarbel,
                       nomenklat, soato::numeric as soato, sovet, sinforus, sinfobel,
                       ""{AteDateColumn}""::timestamp AS daterg, existence,
                       id_obl AS RegionId, id_ra AS DistrictId,
                       id_rodate AS CategoryId, x_wgs, y_wgs
                       FROM kn_dbate
                       WHERE kod_ate = @Id",
                    new { Id = id });

                if (row == null)
                {
                    TempData["ErrorMessage"] = "Запись не найдена";
                    return RedirectToAction("ListAte");
                }

                LoadEditDropdowns(connection, ToIntNull(row.regionid));
                
                var model = new AdminEditAteViewModel
                {
                    Id = ToIntNull(row.id) ?? 0,
                    NAMERUS = row.namerus?.ToString(),
                    NAMEBEL = row.namebel?.ToString(),
                    NAMELAT = row.namelat?.ToString(),
                    UDARRUS = row.udarrus?.ToString(),
                    UDARBEL = row.udarbel?.ToString(),
                    NOMENKLAT = row.nomenklat?.ToString(),
                    SOATO = row.soato == null || row.soato is DBNull ? null : ToLongNull(row.soato),
                    SOVET = row.sovet?.ToString(),
                    SINFORUS = row.sinforus?.ToString(),
                    SINFOBEL = row.sinfobel?.ToString(),
                    DATEREG = row.daterg == null || row.daterg is DBNull ? null : (DateTime?)row.daterg,
                    EXISTENCE = row.existence?.ToString(),
                    RegionId = ToIntNull(row.regionid),
                    DistrictId = ToIntNull(row.districtid),
                    CategoryId = ToIntNull(row.categoryid),
                    X_WGS = ToDoubleNull(row.x_wgs),
                    Y_WGS = ToDoubleNull(row.y_wgs)
                };

                ViewBag.Title = "Редактирование населённого пункта";
                ViewBag.SoatoInfo = "Код СОАТО формируется автоматически на основе области и района";
                return View("EditAte", model);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "EditAte GET");
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction("ListAte");
            }
        }

        [HttpPost]
        [Route("Admin/ATE/Edit/{id:int}")]
        [ValidateAntiForgeryToken]
        public IActionResult EditAte(int id, AdminEditAteViewModel model)
        {
            if (model == null || model.Id != id)
                return RedirectToAction("ListAte");

            try
            {
                using var connection = CreateConnection();
                connection.Execute(
                    $@"UPDATE kn_dbate
                       SET namerus = @NAMERUS, namebel = @NAMEBEL, namelat = @NAMELAT,
                           udarrus = @UDARRUS, udarbel = @UDARBEL, nomenklat = @NOMENKLAT,
                           soato = @SOATO::varchar, sovet = @SOVET, sinforus = @SINFORUS,
                           sinfobel = @SINFOBEL, ""{AteDateColumn}"" = @DATEREG::varchar,
                           existence = @EXISTENCE, id_obl = @RegionId, id_ra = @DistrictId,
                           id_rodate = @CategoryId, x_wgs = @X_WGS, y_wgs = @Y_WGS
                       WHERE kod_ate = @Id",
                    new
                    {
                        model.NAMERUS, model.NAMEBEL, model.NAMELAT, model.UDARRUS, model.UDARBEL,
                        model.NOMENKLAT, model.SOATO, model.SOVET, model.SINFORUS, model.SINFOBEL,
                        model.DATEREG, model.EXISTENCE, model.RegionId, model.DistrictId,
                        model.CategoryId, model.X_WGS, model.Y_WGS, Id = id
                    });

                TempData["SuccessMessage"] = "Изменения сохранены.";
                return RedirectToAction("ListAte");
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "EditAte POST");
                TempData["ErrorMessage"] = ex.Message;
                LoadEditDropdowns(CreateConnection(), model.RegionId);
                return View("EditAte", model);
            }
        }

        [HttpGet]
        [Route("Admin/ATE/Create")]
        public IActionResult CreateAte()
        {
            using var connection = CreateConnection();
            LoadEditDropdowns(connection);
            ViewBag.Title = "Новый населённый пункт";
            ViewBag.SoatoInfo = "Код СОАТО будет сгенерирован автоматически на основе выбранной области и района";
            return View("EditAte", new AdminEditAteViewModel { Id = 0, EXISTENCE = "существует" });
        }

        [HttpPost]
        [Route("Admin/ATE/Create")]
        [ValidateAntiForgeryToken]
        public IActionResult CreateAte(AdminEditAteViewModel model)
        {
            try
            {
                using var connection = CreateConnection();
                var nextId = connection.ExecuteScalar<int>("SELECT COALESCE(MAX(kod_ate), 0) + 1 FROM kn_dbate");
                
                long? soatoToInsert = model.SOATO;
                if (!soatoToInsert.HasValue || soatoToInsert.Value <= 0)
                {
                    soatoToInsert = GenerateSoatoCode(connection, model.RegionId, model.DistrictId, model.SOVET);
                }

                string dateRegValue = model.DATEREG?.ToString("yyyy-MM-dd HH:mm:ss") ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                var newIdObj = connection.ExecuteScalar(
                    $@"INSERT INTO kn_dbate (kod_ate, namerus, namebel, namelat, udarrus, udarbel,
                       nomenklat, soato, sovet, sinforus, sinfobel,
                       ""{AteDateColumn}"", existence, id_obl, id_ra,
                       id_rodate, x_wgs, y_wgs)
                       VALUES (@NewId, @NAMERUS, @NAMEBEL, @NAMELAT, @UDARRUS, @UDARBEL,
                       @NOMENKLAT, @SOATO::varchar, @SOVET, @SINFORUS, @SINFOBEL, @DATEREG::varchar,
                       @EXISTENCE, @RegionId, @DistrictId, @CategoryId, @X_WGS, @Y_WGS)
                       RETURNING kod_ate",
                    new
                    {
                        NewId = nextId,
                        model.NAMERUS, model.NAMEBEL, model.NAMELAT, model.UDARRUS, model.UDARBEL,
                        model.NOMENKLAT, SOATO = soatoToInsert.ToString(), model.SOVET, model.SINFORUS, model.SINFOBEL,
                        DATEREG = dateRegValue, EXISTENCE = model.EXISTENCE ?? "существует",
                        model.RegionId, model.DistrictId, model.CategoryId,
                        model.X_WGS, model.Y_WGS
                    });

                var newId = ToIntNull(newIdObj) ?? 0;
                TempData["SuccessMessage"] = $"Запись создана. СОАТО: {soatoToInsert}";
                return RedirectToAction("EditAte", new { id = newId });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "CreateAte");
                TempData["ErrorMessage"] = ex.Message;
                LoadEditDropdowns(CreateConnection(), model.RegionId);
                return View("EditAte", model);
            }
        }
        #endregion

        #region Edit/Create Actions - Airports
        [HttpGet]
        [Route("Admin/Airports/Edit/{id:int}")]
        public IActionResult EditAirport(int id)
        {
            try
            {
                using var connection = CreateConnection();
                var row = connection.QueryFirstOrDefault<dynamic>(
                    @"SELECT id_air AS Id, namerus, namebel, namelat, udarrus, udarbel,
                             category, nomenklat, geopr, datereg::timestamp AS datereg,
                             obl AS RegionId, ra AS DistrictId, x_wgs, y_wgs
                      FROM kn_dbair
                      WHERE id_air = @Id",
                    new { Id = id });

                if (row == null)
                {
                    TempData["ErrorMessage"] = "Запись не найдена";
                    return RedirectToAction("ListAirports");
                }

                LoadEditDropdowns(connection, ToIntNull(row.regionid));
                
                var model = new AdminEditAirportViewModel
                {
                    Id = ToIntNull(row.id) ?? 0,
                    NAMERUS = row.namerus?.ToString(),
                    NAMEBEL = row.namebel?.ToString(),
                    NAMELAT = row.namelat?.ToString(),
                    UDARRUS = row.udarrus?.ToString(),
                    UDARBEL = row.udarbel?.ToString(),
                    CATEGORY = row.category?.ToString(),
                    NOMENKLAT = row.nomenklat?.ToString(),
                    GEOPR = row.geopr?.ToString(),
                    DATEREG = row.datereg == null || row.datereg is DBNull ? null : (DateTime?)row.datereg,
                    RegionId = ToIntNull(row.regionid),
                    DistrictId = ToIntNull(row.districtid),
                    X_WGS = ToDoubleNull(row.x_wgs),
                    Y_WGS = ToDoubleNull(row.y_wgs)
                };

                ViewBag.Title = "Редактирование аэропорта";
                return View("EditAirport", model);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "EditAirport GET");
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction("ListAirports");
            }
        }

        [HttpPost]
        [Route("Admin/Airports/Edit/{id:int}")]
        [ValidateAntiForgeryToken]
        public IActionResult EditAirport(int id, AdminEditAirportViewModel model)
        {
            if (model == null || model.Id != id)
                return RedirectToAction("ListAirports");

            try
            {
                using var connection = CreateConnection();
                connection.Execute(
                    @"UPDATE kn_dbair
                      SET namerus = @NAMERUS, namebel = @NAMEBEL, namelat = @NAMELAT,
                          udarrus = @UDARRUS, udarbel = @UDARBEL, category = @CATEGORY,
                          nomenklat = @NOMENKLAT, geopr = @GEOPR, datereg = @DATEREG::varchar,
                          obl = @RegionId, ra = @DistrictId, x_wgs = @X_WGS, y_wgs = @Y_WGS
                      WHERE id_air = @Id",
                    new
                    {
                        model.NAMERUS, model.NAMEBEL, model.NAMELAT, model.UDARRUS, model.UDARBEL,
                        model.CATEGORY, model.NOMENKLAT, model.GEOPR, model.DATEREG,
                        model.RegionId, model.DistrictId, model.X_WGS, model.Y_WGS, Id = id
                    });

                TempData["SuccessMessage"] = "Изменения сохранены.";
                return RedirectToAction("ListAirports");
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "EditAirport POST");
                TempData["ErrorMessage"] = ex.Message;
                LoadEditDropdowns(CreateConnection(), model.RegionId);
                return View("EditAirport", model);
            }
        }

        [HttpGet]
        [Route("Admin/Airports/Create")]
        public IActionResult CreateAirport()
        {
            using var connection = CreateConnection();
            LoadEditDropdowns(connection);
            ViewBag.Title = "Новый аэропорт";
            return View("EditAirport", new AdminEditAirportViewModel { Id = 0 });
        }

        [HttpPost]
        [Route("Admin/Airports/Create")]
        [ValidateAntiForgeryToken]
        public IActionResult CreateAirport(AdminEditAirportViewModel model)
        {
            try
            {
                using var connection = CreateConnection();
                var nextId = connection.ExecuteScalar<int>("SELECT COALESCE(MAX(id_air), 0) + 1 FROM kn_dbair");
                string dateRegValue = model.DATEREG?.ToString("yyyy-MM-dd HH:mm:ss") ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                var newIdObj = connection.ExecuteScalar(
                    @"INSERT INTO kn_dbair (id_air, namerus, namebel, namelat, udarrus, udarbel,
                              category, nomenklat, geopr, datereg, obl, ra, x_wgs, y_wgs)
                      VALUES (@NewId, @NAMERUS, @NAMEBEL, @NAMELAT, @UDARRUS, @UDARBEL,
                              @CATEGORY, @NOMENKLAT, @GEOPR, @DATEREG::varchar, @RegionId, @DistrictId,
                              @X_WGS, @Y_WGS)
                      RETURNING id_air",
                    new
                    {
                        NewId = nextId,
                        model.NAMERUS, model.NAMEBEL, model.NAMELAT, model.UDARRUS, model.UDARBEL,
                        model.CATEGORY, model.NOMENKLAT, model.GEOPR, DATEREG = dateRegValue,
                        model.RegionId, model.DistrictId, model.X_WGS, model.Y_WGS
                    });

                var newId = ToIntNull(newIdObj) ?? 0;
                TempData["SuccessMessage"] = "Запись создана.";
                return RedirectToAction("EditAirport", new { id = newId });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "CreateAirport");
                TempData["ErrorMessage"] = ex.Message;
                LoadEditDropdowns(CreateConnection(), model.RegionId);
                return View("EditAirport", model);
            }
        }
        #endregion

        #region Edit/Create Actions - Railway
        [HttpGet]
        [Route("Admin/Railway/Edit/{id:int}")]
        public IActionResult EditRailway(int id)
        {
            try
            {
                using var connection = CreateConnection();
                var row = connection.QueryFirstOrDefault<dynamic>(
                    @"SELECT id_rw AS Id, namerus, namebel, namelat, namenorm, udarrus, udarbel,
                             ecp, nomenklat, geopr, datereg::timestamp AS datereg, existence,
                             obl AS RegionId, ra AS DistrictId, category AS CategoryId,
                             nods AS NodeId, x_wgs, y_wgs
                      FROM kn_dbrw
                      WHERE id_rw = @Id",
                    new { Id = id });

                if (row == null)
                {
                    TempData["ErrorMessage"] = "Запись не найдена";
                    return RedirectToAction("ListRailway");
                }

                LoadEditDropdowns(connection, ToIntNull(row.regionid));
                
                var model = new AdminEditRailwayViewModel
                {
                    Id = ToIntNull(row.id) ?? 0,
                    NAMERUS = row.namerus?.ToString(),
                    NAMEBEL = row.namebel?.ToString(),
                    NAMELAT = row.namelat?.ToString(),
                    NAMENORM = row.namenorm?.ToString(),
                    UDARRUS = row.udarrus?.ToString(),
                    UDARBEL = row.udarbel?.ToString(),
                    ECP = ToIntNull(row.ecp),
                    NOMENKLAT = row.nomenklat?.ToString(),
                    GEOPR = row.geopr?.ToString(),
                    DATEREG = row.datereg == null || row.datereg is DBNull ? null : (DateTime?)row.datereg,
                    EXISTENCE = row.existence?.ToString(),
                    RegionId = ToIntNull(row.regionid),
                    DistrictId = ToIntNull(row.districtid),
                    CategoryId = ToIntNull(row.categoryid),
                    NodeId = ToIntNull(row.nodeid),
                    X_WGS = ToDoubleNull(row.x_wgs),
                    Y_WGS = ToDoubleNull(row.y_wgs)
                };

                ViewBag.Title = "Редактирование ж/д объекта";
                return View("EditRailway", model);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "EditRailway GET");
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction("ListRailway");
            }
        }

        [HttpPost]
        [Route("Admin/Railway/Edit/{id:int}")]
        [ValidateAntiForgeryToken]
        public IActionResult EditRailway(int id, AdminEditRailwayViewModel model)
        {
            if (model == null || model.Id != id)
                return RedirectToAction("ListRailway");

            try
            {
                using var connection = CreateConnection();
                connection.Execute(
                    @"UPDATE kn_dbrw
                      SET namerus = @NAMERUS, namebel = @NAMEBEL, namelat = @NAMELAT,
                          namenorm = @NAMENORM, udarrus = @UDARRUS, udarbel = @UDARBEL,
                          ecp = @ECP, nomenklat = @NOMENKLAT, geopr = @GEOPR,
                          datereg = @DATEREG::varchar, existence = @EXISTENCE, obl = @RegionId,
                          ra = @DistrictId, category = @CategoryId, nods = @NodeId,
                          x_wgs = @X_WGS, y_wgs = @Y_WGS
                      WHERE id_rw = @Id",
                    new
                    {
                        model.NAMERUS, model.NAMEBEL, model.NAMELAT, model.NAMENORM,
                        model.UDARRUS, model.UDARBEL, model.ECP, model.NOMENKLAT,
                        model.GEOPR, model.DATEREG, model.EXISTENCE, model.RegionId,
                        model.DistrictId, model.CategoryId, model.NodeId,
                        model.X_WGS, model.Y_WGS, Id = id
                    });

                TempData["SuccessMessage"] = "Изменения сохранены.";
                return RedirectToAction("ListRailway");
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "EditRailway POST");
                TempData["ErrorMessage"] = ex.Message;
                LoadEditDropdowns(CreateConnection(), model.RegionId);
                return View("EditRailway", model);
            }
        }

        [HttpGet]
        [Route("Admin/Railway/Create")]
        public IActionResult CreateRailway()
        {
            using var connection = CreateConnection();
            LoadEditDropdowns(connection);
            ViewBag.Title = "Новый ж/д объект";
            return View("EditRailway", new AdminEditRailwayViewModel { Id = 0, EXISTENCE = "существует" });
        }

        [HttpPost]
        [Route("Admin/Railway/Create")]
        [ValidateAntiForgeryToken]
        public IActionResult CreateRailway(AdminEditRailwayViewModel model)
        {
            try
            {
                using var connection = CreateConnection();
                var nextId = connection.ExecuteScalar<int>("SELECT COALESCE(MAX(id_rw), 0) + 1 FROM kn_dbrw");
                
                int? ecpToInsert = model.ECP;
                if (!ecpToInsert.HasValue || ecpToInsert.Value <= 0)
                {
                    var nextEcp = connection.ExecuteScalar<int>(
                        "SELECT COALESCE(MAX(ecp), 0) + 1 FROM kn_dbrw WHERE ecp IS NOT NULL");
                    ecpToInsert = nextEcp;
                }

                string dateRegValue = model.DATEREG?.ToString("yyyy-MM-dd HH:mm:ss") ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                var newIdObj = connection.ExecuteScalar(
                    @"INSERT INTO kn_dbrw (id_rw, namerus, namebel, namelat, namenorm, udarrus, udarbel,
                              ecp, nomenklat, geopr, datereg, existence, obl, ra,
                              category, nods, x_wgs, y_wgs)
                      VALUES (@NewId, @NAMERUS, @NAMEBEL, @NAMELAT, @NAMENORM, @UDARRUS, @UDARBEL,
                              @ECP, @NOMENKLAT, @GEOPR, @DATEREG::varchar, @EXISTENCE, @RegionId, @DistrictId,
                              @CategoryId, @NodeId, @X_WGS, @Y_WGS)
                      RETURNING id_rw",
                    new
                    {
                        NewId = nextId,
                        model.NAMERUS, model.NAMEBEL, model.NAMELAT, model.NAMENORM,
                        model.UDARRUS, model.UDARBEL, ECP = ecpToInsert, model.NOMENKLAT,
                        model.GEOPR, DATEREG = dateRegValue,
                        EXISTENCE = model.EXISTENCE ?? "существует",
                        model.RegionId, model.DistrictId, model.CategoryId,
                        model.NodeId, model.X_WGS, model.Y_WGS
                    });

                var newId = ToIntNull(newIdObj) ?? 0;
                TempData["SuccessMessage"] = "Запись создана.";
                return RedirectToAction("EditRailway", new { id = newId });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "CreateRailway");
                TempData["ErrorMessage"] = ex.Message;
                LoadEditDropdowns(CreateConnection(), model.RegionId);
                return View("EditRailway", model);
            }
        }
        #endregion

        #region Edit/Create Actions - FGO
        [HttpGet]
        [Route("Admin/FGO/Edit/{id:int}")]
        public IActionResult EditFgo(int id)
        {
            try
            {
                using var connection = CreateConnection();
                var row = connection.QueryFirstOrDefault<dynamic>(
                    @"SELECT id_fgo AS Id, namerus, namebel, namelat, udarrus, udarbel,
                             nomenklat, geopr AS Description, sinforus, sinfobel, datereg::timestamp AS datereg,
                             existence, obl AS RegionId, ra AS DistrictId, rodfgo AS TypeId,
                             x_wgs, y_wgs, basriver AS Basin, pritok AS Tributary, fall,
                             distance, area, depth, sudohod AS Navigable, specnotes AS SpecialNotes
                      FROM kn_dbfgo
                      WHERE id_fgo = @Id",
                    new { Id = id });

                if (row == null)
                {
                    TempData["ErrorMessage"] = "Запись не найдена";
                    return RedirectToAction("ListFgo");
                }

                LoadEditDropdowns(connection, ToIntNull(row.regionid));
                
                var model = new AdminEditFgoViewModel
                {
                    Id = ToIntNull(row.id) ?? 0,
                    NAMERUS = row.namerus?.ToString(),
                    NAMEBEL = row.namebel?.ToString(),
                    NAMELAT = row.namelat?.ToString(),
                    UDARRUS = row.udarrus?.ToString(),
                    UDARBEL = row.udarbel?.ToString(),
                    NOMENKLAT = row.nomenklat?.ToString(),
                    Description = row.description?.ToString(),
                    SINFORUS = row.sinforus?.ToString(),
                    SINFOBEL = row.sinfobel?.ToString(),
                    DATEREG = row.datereg == null || row.datereg is DBNull ? null : (DateTime?)row.datereg,
                    EXISTENCE = row.existence?.ToString(),
                    RegionId = ToIntNull(row.regionid),
                    DistrictId = ToIntNull(row.districtid),
                    TypeId = ToIntNull(row.typeid),
                    X_WGS = ToDoubleNull(row.x_wgs),
                    Y_WGS = ToDoubleNull(row.y_wgs),
                    Basin = row.basin?.ToString(),
                    Tributary = row.tributary?.ToString(),
                    FALL = row.fall?.ToString(),
                    DISTANCE = ToDoubleNull(row.distance),
                    AREA = ToDoubleNull(row.area),
                    DEPTH = ToDoubleNull(row.depth),
                    Navigable = row.navigable?.ToString(),
                    SpecialNotes = row.specialnotes?.ToString()
                };

                ViewBag.Title = "Редактирование физ.-геогр. объекта";
                return View("EditFgo", model);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "EditFgo GET");
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction("ListFgo");
            }
        }

        [HttpPost]
        [Route("Admin/FGO/Edit/{id:int}")]
        [ValidateAntiForgeryToken]
        public IActionResult EditFgo(int id, AdminEditFgoViewModel model)
        {
            if (model == null || model.Id != id)
                return RedirectToAction("ListFgo");

            try
            {
                using var connection = CreateConnection();
                connection.Execute(
                    @"UPDATE kn_dbfgo
                      SET namerus = @NAMERUS, namebel = @NAMEBEL, namelat = @NAMELAT,
                          udarrus = @UDARRUS, udarbel = @UDARBEL, nomenklat = @NOMENKLAT,
                          geopr = @Description, sinforus = @SINFORUS, sinfobel = @SINFOBEL,
                          datereg = @DATEREG::varchar, existence = @EXISTENCE, obl = @RegionId,
                          ra = @DistrictId, rodfgo = @TypeId, x_wgs = @X_WGS, y_wgs = @Y_WGS,
                          basriver = @Basin, pritok = @Tributary, fall = @FALL,
                          distance = @DISTANCE, area = @AREA, depth = @DEPTH,
                          sudohod = @Navigable, specnotes = @SpecialNotes
                      WHERE id_fgo = @Id",
                    new
                    {
                        model.NAMERUS, model.NAMEBEL, model.NAMELAT, model.UDARRUS, model.UDARBEL,
                        model.NOMENKLAT, model.Description, model.SINFORUS, model.SINFOBEL,
                        model.DATEREG, model.EXISTENCE, model.RegionId, model.DistrictId,
                        model.TypeId, model.X_WGS, model.Y_WGS, model.Basin, model.Tributary,
                        model.FALL, model.DISTANCE, model.AREA, model.DEPTH,
                        model.Navigable, model.SpecialNotes, Id = id
                    });

                TempData["SuccessMessage"] = "Изменения сохранены.";
                return RedirectToAction("ListFgo");
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "EditFgo POST");
                TempData["ErrorMessage"] = ex.Message;
                LoadEditDropdowns(CreateConnection(), model.RegionId);
                return View("EditFgo", model);
            }
        }

        [HttpGet]
        [Route("Admin/FGO/Create")]
        public IActionResult CreateFgo()
        {
            using var connection = CreateConnection();
            LoadEditDropdowns(connection);
            ViewBag.Title = "Новый физ.-геогр. объект";
            return View("EditFgo", new AdminEditFgoViewModel { Id = 0, EXISTENCE = "существует" });
        }

        [HttpPost]
        [Route("Admin/FGO/Create")]
        [ValidateAntiForgeryToken]
        public IActionResult CreateFgo(AdminEditFgoViewModel model)
        {
            try
            {
                using var connection = CreateConnection();
                var nextId = connection.ExecuteScalar<int>("SELECT COALESCE(MAX(id_fgo), 0) + 1 FROM kn_dbfgo");
                string dateRegValue = model.DATEREG?.ToString("yyyy-MM-dd HH:mm:ss") ?? DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

                var newIdObj = connection.ExecuteScalar(
                    @"INSERT INTO kn_dbfgo (id_fgo, namerus, namebel, namelat, udarrus, udarbel,
                              nomenklat, geopr, sinforus, sinfobel, datereg,
                              existence, obl, ra, rodfgo, x_wgs, y_wgs,
                              basriver, pritok, fall, distance, area, depth,
                              sudohod, specnotes)
                      VALUES (@NewId, @NAMERUS, @NAMEBEL, @NAMELAT, @UDARRUS, @UDARBEL,
                              @NOMENKLAT, @Description, @SINFORUS, @SINFOBEL, @DATEREG::varchar,
                              @EXISTENCE, @RegionId, @DistrictId, @TypeId, @X_WGS, @Y_WGS,
                              @Basin, @Tributary, @FALL, @DISTANCE, @AREA, @DEPTH,
                              @Navigable, @SpecialNotes)
                      RETURNING id_fgo",
                    new
                    {
                        NewId = nextId,
                        model.NAMERUS, model.NAMEBEL, model.NAMELAT, model.UDARRUS, model.UDARBEL,
                        model.NOMENKLAT, model.Description, model.SINFORUS, model.SINFOBEL,
                        DATEREG = dateRegValue, EXISTENCE = model.EXISTENCE ?? "существует",
                        model.RegionId, model.DistrictId, model.TypeId,
                        model.X_WGS, model.Y_WGS, model.Basin, model.Tributary,
                        model.FALL, model.DISTANCE, model.AREA, model.DEPTH,
                        model.Navigable, model.SpecialNotes
                    });

                var newId = ToIntNull(newIdObj) ?? 0;
                TempData["SuccessMessage"] = "Запись создана.";
                return RedirectToAction("EditFgo", new { id = newId });
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "CreateFgo");
                TempData["ErrorMessage"] = ex.Message;
                LoadEditDropdowns(CreateConnection(), model.RegionId);
                return View("EditFgo", model);
            }
        }
        #endregion

        #region Delete Actions
        [HttpPost]
        [Route("Admin/ATE/Delete/{id:int}")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteAte(int id)
        {
            try
            {
                using var connection = CreateConnection();
                connection.Execute("DELETE FROM kn_dbate WHERE kod_ate = @Id", new { Id = id });
                TempData["SuccessMessage"] = "Запись удалена.";
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при удалении ATE {Id}", id);
                TempData["ErrorMessage"] = "Ошибка при удалении: " + ex.Message;
            }
            return RedirectToAction("ListAte");
        }

        [HttpPost]
        [Route("Admin/Airports/Delete/{id:int}")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteAirport(int id)
        {
            try
            {
                using var connection = CreateConnection();
                connection.Execute("DELETE FROM kn_dbair WHERE id_air = @Id", new { Id = id });
                TempData["SuccessMessage"] = "Запись удалена.";
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при удалении Airport {Id}", id);
                TempData["ErrorMessage"] = "Ошибка при удалении: " + ex.Message;
            }
            return RedirectToAction("ListAirports");
        }

        [HttpPost]
        [Route("Admin/Railway/Delete/{id:int}")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteRailway(int id)
        {
            try
            {
                using var connection = CreateConnection();
                connection.Execute("DELETE FROM kn_dbrw WHERE id_rw = @Id", new { Id = id });
                TempData["SuccessMessage"] = "Запись удалена.";
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при удалении Railway {Id}", id);
                TempData["ErrorMessage"] = "Ошибка при удалении: " + ex.Message;
            }
            return RedirectToAction("ListRailway");
        }

        [HttpPost]
        [Route("Admin/FGO/Delete/{id:int}")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteFgo(int id)
        {
            try
            {
                using var connection = CreateConnection();
                connection.Execute("DELETE FROM kn_dbfgo WHERE id_fgo = @Id", new { Id = id });
                TempData["SuccessMessage"] = "Запись удалена.";
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при удалении FGO {Id}", id);
                TempData["ErrorMessage"] = "Ошибка при удалении: " + ex.Message;
            }
            return RedirectToAction("ListFgo");
        }
        #endregion

        #region Helper Methods - Dropdowns
        private void LoadRegions(NpgsqlConnection connection)
        {
            var regions = connection.Query<SelectListItem>(
                "SELECT id_obl::text AS Value, obl AS Text FROM kn_obl ORDER BY obl").ToList();
            
            // Добавляем пустой элемент для сброса фильтра
            regions.Insert(0, new SelectListItem { Value = "", Text = "-- Все области --" });
            ViewBag.Regions = regions;
        }

        private void LoadListDropdowns(NpgsqlConnection connection, int? regionId)
        {
            LoadRegions(connection);

            var regionIdsWithoutDistricts = QueryRegionIdsWithNoDistricts(connection);
            ViewBag.RegionIdsWithNoDistricts = regionIdsWithoutDistricts;

            ViewBag.Districts = new List<SelectListItem>();

            // Загружаем районы только если выбрана область и для неё предусмотрен выбор района (как в каталоге: г. Минск и др.).
            if (regionId.HasValue && regionId.Value > 0
                && !regionIdsWithoutDistricts.Contains(regionId.Value))
            {
                ViewBag.Districts = GetDistrictsByRegion(connection, regionId.Value);
            }
            
            // Добавляем пустой элемент для сброса фильтра
            if (ViewBag.Districts is List<SelectListItem> districts && districts.Count > 0)
            {
                districts.Insert(0, new SelectListItem { Value = "", Text = "-- Все районы --" });
            }
            else
            {
                ViewBag.Districts = new List<SelectListItem> 
                { 
                    new SelectListItem { Value = "", Text = "-- Все районы --" } 
                };
            }
        }

        private void LoadEditDropdowns(NpgsqlConnection connection, int? regionId = null)
        {
            var regionIdsWithoutDistricts = QueryRegionIdsWithNoDistricts(connection);
            ViewBag.RegionIdsWithoutDistricts = regionIdsWithoutDistricts;

            ViewBag.Regions = connection.Query<SelectListItem>(
                "SELECT id_obl::text AS Value, obl AS Text FROM kn_obl ORDER BY obl").ToList();
            
            ViewBag.Regions.Insert(0, new SelectListItem { Value = "", Text = "-- Выберите область --" });

            ViewBag.Districts = new List<SelectListItem>();
            if (regionId.HasValue && regionId.Value > 0
                && !regionIdsWithoutDistricts.Contains(regionId.Value))
            {
                ViewBag.Districts = GetDistrictsByRegion(connection, regionId.Value);
            }
            
            ViewBag.Districts.Insert(0, new SelectListItem { Value = "", Text = "-- Выберите район --" });

            ViewBag.AteTypes = connection.Query<SelectListItem>(
                "SELECT id_rodate::text AS Value, ratename AS Text FROM kn_rodate ORDER BY ratename").ToList();
            ViewBag.AteTypes.Insert(0, new SelectListItem { Value = "", Text = "-- Выберите тип --" });

            ViewBag.RailwayCategories = connection.Query<SelectListItem>(
                "SELECT id_categor::text AS Value, nkod AS Text FROM kn_category ORDER BY nkod").ToList();
            ViewBag.RailwayCategories.Insert(0, new SelectListItem { Value = "", Text = "-- Выберите категорию --" });

            ViewBag.RailwayNodes = connection.Query<SelectListItem>(
                "SELECT id_nod::text AS Value, nod AS Text FROM kn_nod ORDER BY nod").ToList();
            ViewBag.RailwayNodes.Insert(0, new SelectListItem { Value = "", Text = "-- Выберите узел --" });

            ViewBag.FgoTypes = connection.Query<SelectListItem>(
                "SELECT id_rodfgo::text AS Value, rfgoname AS Text FROM kn_rodfgo ORDER BY rfgoname").ToList();
            ViewBag.FgoTypes.Insert(0, new SelectListItem { Value = "", Text = "-- Выберите тип --" });
        }

        private static bool TryParseRegionId(string? s, out int regionId)
        {
            regionId = 0;
            if (string.IsNullOrWhiteSpace(s)) return false;
            s = s.Trim();
            if (int.TryParse(s, NumberStyles.Integer, CultureInfo.InvariantCulture, out regionId) && regionId > 0)
                return true;
            if (double.TryParse(s, NumberStyles.Float, CultureInfo.InvariantCulture, out var d))
            {
                regionId = (int)Math.Truncate(d);
                return regionId > 0;
            }
            return false;
        }

        /// <summary>
        /// Области без выбора района в формах админки (как в каталоге: г. Минск и области без привязок в справочниках).
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

        /// <summary>
        /// Районы области: несколько независимых запросов, чтобы ошибка в одной таблице/колонке не обнуляла весь список.
        /// </summary>
        private List<SelectListItem> GetDistrictsByRegion(NpgsqlConnection connection, int regionId)
        {
            var byValue = new Dictionary<string, SelectListItem>(StringComparer.Ordinal);
            void Merge(IEnumerable<SelectListItem> rows)
            {
                foreach (var row in rows)
                {
                    if (string.IsNullOrWhiteSpace(row.Value)) continue;
                    byValue[row.Value] = row;
                }
            }
            void TryQuery(string label, string sql)
            {
                try
                {
                    Merge(connection.Query<SelectListItem>(sql, new { RegionId = regionId }));
                }
                catch (Exception ex)
                {
                    _logger?.LogDebug(ex, "GetDistrictsByRegion: фрагмент «{Label}» пропущен для региона {RegionId}", label, regionId);
                }
            }

            TryQuery("kn_ra.id_obl",
                "SELECT id_ra::text AS Value, ra AS Text FROM kn_ra WHERE id_obl = @RegionId ORDER BY ra");
            TryQuery("kn_dbate",
                @"SELECT DISTINCT ra.id_ra::text AS Value, ra.ra AS Text
                  FROM kn_ra ra
                  INNER JOIN kn_dbate b ON b.id_ra = ra.id_ra
                  WHERE b.id_obl = @RegionId AND b.id_ra IS NOT NULL
                  ORDER BY ra.ra");
            TryQuery("kn_dbair",
                @"SELECT DISTINCT ra.id_ra::text AS Value, ra.ra AS Text
                  FROM kn_ra ra
                  INNER JOIN kn_dbair a ON a.ra = ra.id_ra AND a.obl = @RegionId AND a.ra IS NOT NULL
                  ORDER BY ra.ra");
            TryQuery("kn_dbfgo",
                @"SELECT DISTINCT ra.id_ra::text AS Value, ra.ra AS Text
                  FROM kn_ra ra
                  INNER JOIN kn_dbfgo f ON f.ra = ra.id_ra AND f.obl = @RegionId AND f.ra IS NOT NULL
                  ORDER BY ra.ra");
            TryQuery("kn_dbrw",
                @"SELECT DISTINCT ra.id_ra::text AS Value, ra.ra AS Text
                  FROM kn_ra ra
                  INNER JOIN kn_dbrw w ON w.ra = ra.id_ra AND w.obl = @RegionId AND w.ra IS NOT NULL
                  ORDER BY ra.ra");
            TryQuery("kn_dbfgo_obl_ra",
                @"SELECT DISTINCT ra.id_ra::text AS Value, ra.ra AS Text
                  FROM kn_ra ra
                  INNER JOIN kn_dbfgo_obl_ra x ON x.ra = ra.id_ra AND x.obl = @RegionId AND x.ra IS NOT NULL
                  ORDER BY ra.ra");

            var list = byValue.Values.OrderBy(x => x.Text ?? "", StringComparer.CurrentCultureIgnoreCase).ToList();
            _logger?.LogInformation("Найдено районов для региона {RegionId}: {Count}", regionId, list.Count);
            return list;
        }

        // ✅ AJAX endpoint для динамической загрузки районов
        [HttpGet]
        public IActionResult GetDistrictsForAdmin([FromQuery] string? regionId = null)
        {
            try
            {
                if (!TryParseRegionId(regionId, out var rid))
                    return Json(new List<object>());

                using var connection = CreateConnection();
                if (QueryRegionIdsWithNoDistricts(connection).Contains(rid))
                    return Json(new List<object>());

                var list = GetDistrictsByRegion(connection, rid);

                _logger?.LogInformation("GetDistrictsForAdmin: RegionId={RegionId}, Count={Count}",
                    rid, list.Count);

                var json = list.Select(x => new {
                    value = x.Value ?? "",
                    text = x.Text ?? ""
                }).ToList();

                return Json(json);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при получении районов для regionId={RegionId}", regionId);
                return Json(new List<object>());
            }
        }
        #endregion

        #region Reports
        [HttpGet]
        [Route("Admin/Reports")]
        public IActionResult Reports(string searchQuery = null, string objectType = null,
            int? regionId = null, int? districtId = null,
            DateTime? createdFrom = null, DateTime? createdTo = null,
            List<string>? reportObjectTypes = null, List<string>? reportSubtypeTags = null,
            string? reportExistence = null,
            int? foundationYearFrom = null, int? foundationYearTo = null,
            int? minPopulation = null, int? maxPopulation = null, string sortBy = null)
        {
            try
            {
                using var connection = CreateConnection();
                LoadListDropdowns(connection, regionId);

                var rot = reportObjectTypes?.Where(x => !string.IsNullOrWhiteSpace(x)).Select(x => x.Trim().ToUpperInvariant()).Distinct().ToList()
                    ?? new List<string>();
                if (rot.Count == 0 && !string.IsNullOrWhiteSpace(objectType))
                    rot = new List<string> { objectType.Trim().ToUpperInvariant() };
                
                var model = new SearchModel
                {
                    SearchQuery = searchQuery,
                    ObjectType = objectType,
                    RegionId = regionId,
                    DistrictId = districtId,
                    CreatedFrom = createdFrom,
                    CreatedTo = createdTo,
                    ReportObjectTypes = rot.Count > 0 ? rot : null,
                    ReportSubtypeTags = reportSubtypeTags,
                    ReportExistence = reportExistence ?? "exists",
                    FoundationYearFrom = foundationYearFrom,
                    FoundationYearTo = foundationYearTo,
                    MinPopulation = minPopulation,
                    MaxPopulation = maxPopulation,
                    SortBy = sortBy
                };
                
                return View("Reports", model);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка при открытии страницы отчетов");
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToAction("Index");
            }
        }

        /// <summary>Подтипы для отчёта по выбранным типам объектов.</summary>
        [HttpGet]
        [Route("Admin/GetReportSubtypes")]
        public IActionResult GetReportSubtypes([FromQuery] string[] types)
        {
            try
            {
                if (types == null || types.Length == 0)
                    return Json(new List<object>());

                var codes = types
                    .Select(t => (t ?? "").Trim().ToUpperInvariant())
                    .Where(t => t.Length > 0)
                    .Distinct(StringComparer.OrdinalIgnoreCase)
                    .ToList();

                using var connection = CreateConnection();
                var result = new List<object>();

                foreach (var code in codes.OrderBy(x => x))
                {
                    IEnumerable<string> names = null;
                    switch (code)
                    {
                        case "ATE":
                            names = connection.Query<string>(
                                @"SELECT DISTINCT TRIM(rt.ratename) AS n FROM kn_dbate b
                                  INNER JOIN kn_rodate rt ON b.id_rodate = rt.id_rodate
                                  WHERE rt.ratename IS NOT NULL AND TRIM(rt.ratename) <> ''
                                  ORDER BY 1");
                            break;
                        case "AIR":
                            names = connection.Query<string>(
                                @"SELECT DISTINCT TRIM(a.category) AS n FROM kn_dbair a
                                  WHERE a.category IS NOT NULL AND TRIM(a.category) <> ''
                                  ORDER BY 1");
                            break;
                        case "RW":
                            names = connection.Query<string>(
                                @"SELECT DISTINCT TRIM(c.nkod) AS n FROM kn_dbrw rw
                                  LEFT JOIN kn_category c ON rw.category = c.id_categor
                                  WHERE c.nkod IS NOT NULL AND TRIM(c.nkod) <> ''
                                  ORDER BY 1");
                            break;
                        case "FGO":
                            names = connection.Query<string>(
                                @"SELECT DISTINCT TRIM(rf.rfgoname) AS n FROM kn_dbfgo f
                                  LEFT JOIN kn_rodfgo rf ON f.rodfgo = rf.id_rodfgo
                                  WHERE rf.rfgoname IS NOT NULL AND TRIM(rf.rfgoname) <> ''
                                  ORDER BY 1");
                            break;
                    }

                    if (names == null) continue;
                    foreach (var name in names)
                    {
                        if (string.IsNullOrWhiteSpace(name)) continue;
                        var tag = $"{code}||{name}";
                        result.Add(new { typeCode = code, value = tag, text = name });
                    }
                }

                return Json(result);
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "Ошибка GetReportSubtypes");
                return Json(new List<object>());
            }
        }
        #endregion
    }
}