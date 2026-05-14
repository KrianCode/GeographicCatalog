using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace GeographicCatalog.Models
{
    // Модель для поиска
    public class SearchModel
    {
        // Существующие свойства
        public string SearchQuery { get; set; }
        public string ObjectType { get; set; }
        public string FirstLetter { get; set; }
        public int? RegionId { get; set; }
        public int? DistrictId { get; set; }
        public int? StatusId { get; set; }
        public int? MinPopulation { get; set; }
        public int? MaxPopulation { get; set; }
        public int? MinElevation { get; set; }
        public int? MaxElevation { get; set; }
        public int? FoundationYearFrom { get; set; }
        public int? FoundationYearTo { get; set; }
        public string SortBy { get; set; }
        // Фильтрация по дате создания объекта (CreatedDate в объединённом запросе)
        [DataType(DataType.Date)]
        public DateTime? CreatedFrom { get; set; }

        [DataType(DataType.Date)]
        public DateTime? CreatedTo { get; set; }
        public int Page { get; set; } = 1;
        public int PageSize { get; set; } = 50;
        public List<SearchResult> Results { get; set; } = new List<SearchResult>();
        public int TotalCount { get; set; }
        public List<string> Alphabet { get; set; } = new List<string>();

        // Добавьте эти свойства
        public int TotalPages
        {
            get
            {
                if (PageSize == 0) return 0;
                return (int)Math.Ceiling((double)TotalCount / PageSize);
            }
        }

        // Добавьте словарь типов объектов
        public Dictionary<string, string> ObjectTypes { get; } = new Dictionary<string, string>
    {
        { "", "Все типы" },
        { "ATE", "Населенные пункты" },
        { "AIR", "Аэропорты" },
        { "RW", "Железнодорожные объекты" },
        { "FGO", "Физ.-гео. объекты" }
    };

        /// <summary>Коды типов для отчёта (чекбоксы). Пусто — все типы.</summary>
        public List<string>? ReportObjectTypes { get; set; }

        /// <summary>Подтипы в формате TYPE||TypeName (как в справочнике).</summary>
        public List<string>? ReportSubtypeTags { get; set; }

        /// <summary>Пусто или "any" — без фильтра по статусу; "exists" — существует/NULL; "not_exists" — иное значение existence.</summary>
        public string? ReportExistence { get; set; }
    }

    public enum CatalogSearchMode
    {
        Catalog,
        AdminReport
    }

    // Модель результата поиска
    public class SearchResult
    {
        public string ObjectType { get; set; }
        public int ObjectId { get; set; }
        public string NameRu { get; set; }
        public string NameBe { get; set; }
        public string TypeName { get; set; }
        public string RegionName { get; set; }
        public string DistrictName { get; set; }
        public double? Longitude { get; set; }
        public double? Latitude { get; set; }
        public int? Population { get; set; }
        public int? Elevation { get; set; }
        public int? FoundationYear { get; set; }
        public string PostalCode { get; set; }
        public string Nomenklat { get; set; }
        public string StatusName { get; set; }
        public DateTime CreatedDate { get; set; }
        public int TotalCount { get; set; }

        // Для удобства отображения
        public string Coordinates {  get; set; }
    }
}