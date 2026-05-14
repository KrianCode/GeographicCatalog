using System.ComponentModel.DataAnnotations;

namespace GeographicCatalog.Models
{
    /// <summary>Форма редактирования населённого пункта (АТЕ)</summary>
    public class AdminEditAteViewModel
    {
        public int Id { get; set; }

        [Display(Name = "Название (рус.)")]
        public string? NAMERUS { get; set; }

        [Display(Name = "Название (бел.)")]
        public string? NAMEBEL { get; set; }

        [Display(Name = "Название (лат.)")]
        public string? NAMELAT { get; set; }

        [Display(Name = "Ударение (рус.)")]
        public string? UDARRUS { get; set; }

        [Display(Name = "Ударение (бел.)")]
        public string? UDARBEL { get; set; }

        [Display(Name = "Номенклатура")]
        public string? NOMENKLAT { get; set; }

        [Display(Name = "СОАТО")]
        public long? SOATO { get; set; }

        [Display(Name = "Сельсовет")]
        public string? SOVET { get; set; }

        [Display(Name = "Справка (рус.)")]
        public string? SINFORUS { get; set; }

        [Display(Name = "Справка (бел.)")]
        public string? SINFOBEL { get; set; }

        [Display(Name = "Дата регистрации")]
        [DataType(DataType.Date)]
        public DateTime? DATEREG { get; set; }

        [Display(Name = "Существование")]
        public string? EXISTENCE { get; set; }

        [Display(Name = "Область")]
        public int? RegionId { get; set; }

        [Display(Name = "Район")]
        public int? DistrictId { get; set; }

        [Display(Name = "Тип АТЕ (ID_RODATE)")]
        public int? CategoryId { get; set; }

        [Display(Name = "Долгота (Y_WGS)")]
        public double? Y_WGS { get; set; }

        [Display(Name = "Широта (X_WGS)")]
        public double? X_WGS { get; set; }

        [Display(Name = "Описание (рус.)")]
        public string? DescriptionRu { get; set; }
    }

    /// <summary>Форма редактирования аэропорта</summary>
    public class AdminEditAirportViewModel
    {
        public int Id { get; set; }

        [Display(Name = "Название (рус.)")]
        public string? NAMERUS { get; set; }

        [Display(Name = "Название (бел.)")]
        public string? NAMEBEL { get; set; }

        [Display(Name = "Название (лат.)")]
        public string? NAMELAT { get; set; }

        [Display(Name = "Ударение (рус.)")]
        public string? UDARRUS { get; set; }

        [Display(Name = "Ударение (бел.)")]
        public string? UDARBEL { get; set; }

        [Display(Name = "Категория")]
        public string? CATEGORY { get; set; }

        [Display(Name = "Номенклатура")]
        public string? NOMENKLAT { get; set; }

        [Display(Name = "Геопривязка")]
        public string? GEOPR { get; set; }

        [Display(Name = "Дата регистрации")]
        [DataType(DataType.Date)]
        public DateTime? DATEREG { get; set; }

        [Display(Name = "Область")]
        public int? RegionId { get; set; }

        [Display(Name = "Район")]
        public int? DistrictId { get; set; }

        [Display(Name = "Долгота (Y_WGS)")]
        public double? Y_WGS { get; set; }

        [Display(Name = "Широта (X_WGS)")]
        public double? X_WGS { get; set; }

        [Display(Name = "IATA")]
        public string? IATA_Code { get; set; }

        [Display(Name = "ICAO")]
        public string? ICAO_Code { get; set; }

        [Display(Name = "Кол-во ВПП")]
        public int? RunwaysCount { get; set; }

        [Display(Name = "Длина ВПП (м)")]
        public int? LongestRunway { get; set; }

        [Display(Name = "Высота (футы)")]
        public int? ElevationFeet { get; set; }

        [Display(Name = "Описание (рус.)")]
        public string? DescriptionRu { get; set; }

        [Display(Name = "Сайт")]
        public string? Website { get; set; }

        [Display(Name = "Телефон")]
        public string? ContactPhone { get; set; }
    }

    /// <summary>Форма редактирования ж/д объекта</summary>
    public class AdminEditRailwayViewModel
    {
        public int Id { get; set; }

        [Display(Name = "Название (рус.)")]
        public string? NAMERUS { get; set; }

        [Display(Name = "Название (бел.)")]
        public string? NAMEBEL { get; set; }

        [Display(Name = "Название (лат.)")]
        public string? NAMELAT { get; set; }

        [Display(Name = "Нормализованное название")]
        public string? NAMENORM { get; set; }

        [Display(Name = "Ударение (рус.)")]
        public string? UDARRUS { get; set; }

        [Display(Name = "Ударение (бел.)")]
        public string? UDARBEL { get; set; }

        [Display(Name = "Код ЕСР")]
        public int? ECP { get; set; }

        [Display(Name = "Номенклатура")]
        public string? NOMENKLAT { get; set; }

        [Display(Name = "Геопривязка")]
        public string? GEOPR { get; set; }

        [Display(Name = "Дата регистрации")]
        [DataType(DataType.Date)]
        public DateTime? DATEREG { get; set; }

        [Display(Name = "Существование")]
        public string? EXISTENCE { get; set; }

        [Display(Name = "Область")]
        public int? RegionId { get; set; }

        [Display(Name = "Район")]
        public int? DistrictId { get; set; }

        [Display(Name = "Категория (ID_CATEGOR)")]
        public int? CategoryId { get; set; }

        [Display(Name = "Узел (ID_NOD)")]
        public int? NodeId { get; set; }

        [Display(Name = "Долгота (Y_WGS)")]
        public double? Y_WGS { get; set; }

        [Display(Name = "Широта (X_WGS)")]
        public double? X_WGS { get; set; }

        [Display(Name = "Кол-во путей")]
        public int? TracksCount { get; set; }

        [Display(Name = "Кол-во платформ")]
        public int? PlatformsCount { get; set; }

        [Display(Name = "Высота (м)")]
        public int? Elevation { get; set; }

        [Display(Name = "Описание (рус.)")]
        public string? DescriptionRu { get; set; }
    }

    /// <summary>Форма редактирования физ.-гео. объекта (ФГО)</summary>
    public class AdminEditFgoViewModel
    {
        public int Id { get; set; }

        [Display(Name = "Название (рус.)")]
        public string? NAMERUS { get; set; }

        [Display(Name = "Название (бел.)")]
        public string? NAMEBEL { get; set; }

        [Display(Name = "Название (лат.)")]
        public string? NAMELAT { get; set; }

        [Display(Name = "Ударение (рус.)")]
        public string? UDARRUS { get; set; }

        [Display(Name = "Ударение (бел.)")]
        public string? UDARBEL { get; set; }

        [Display(Name = "Номенклатура")]
        public string? NOMENKLAT { get; set; }

        [Display(Name = "Описание (геопривязка)")]
        public string? Description { get; set; }

        [Display(Name = "Справка (рус.)")]
        public string? SINFORUS { get; set; }

        [Display(Name = "Справка (бел.)")]
        public string? SINFOBEL { get; set; }

        [Display(Name = "Дата регистрации")]
        [DataType(DataType.Date)]
        public DateTime? DATEREG { get; set; }

        [Display(Name = "Существование")]
        public string? EXISTENCE { get; set; }

        [Display(Name = "Область")]
        public int? RegionId { get; set; }

        [Display(Name = "Район")]
        public int? DistrictId { get; set; }

        [Display(Name = "Тип ФГО (ID_RODFGO)")]
        public int? TypeId { get; set; }

        [Display(Name = "Долгота (Y_WGS)")]
        public double? Y_WGS { get; set; }

        [Display(Name = "Широта (X_WGS)")]
        public double? X_WGS { get; set; }

        [Display(Name = "Бассейн реки")]
        public string? Basin { get; set; }

        [Display(Name = "Приток")]
        public string? Tributary { get; set; }

        [Display(Name = "Впадает в")]
        public string? FALL { get; set; }

        [Display(Name = "Расстояние (км)")]
        public double? DISTANCE { get; set; }

        [Display(Name = "Площадь (км²)")]
        public double? AREA { get; set; }

        [Display(Name = "Глубина/высота (м)")]
        public double? DEPTH { get; set; }

        [Display(Name = "Судоходство")]
        public string? Navigable { get; set; }

        [Display(Name = "Особые отметки")]
        public string? SpecialNotes { get; set; }
    }
}
