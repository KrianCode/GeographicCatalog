namespace GeographicCatalog.Models
{
    public class AdministrativeUnit
    {
        public int ID { get; set; }
        public int KOD_ATE { get; set; }
        public DateTime? DATEREG { get; set; }
        public long? SOATO { get; set; }
        public string ATENAME { get; set; }
        public string NAMERUS { get; set; }
        public string UDARRUS { get; set; }
        public string NAMEBEL { get; set; }
        public string UDARBEL { get; set; }
        public string NAMELAT { get; set; }

        public string CategoryName { get; set; }
        public string CategoryCode { get; set; }
        public string EXISTENCE { get; set; }
        public string RegionName { get; set; }
        public int RegionId { get; set; }
        public string DistrictName { get; set; }
        public string? AteValueName { get; set; }
        public int? DistrictId { get; set; }
        public string SOVET { get; set; }
        public int? ADMINCENTE { get; set; }
        public string AdminCenterType { get; set; }
        public string SINFORUS { get; set; }
        public string SINFOBEL { get; set; }
        public string NOMENKLAT { get; set; }
        public double? X_WGS { get; set; }
        public double? Y_WGS { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string PostalCode { get; set; }
        public int? Population { get; set; }
        public int? PopulationYear { get; set; }
        public int? FoundationYear { get; set; }
        public decimal? AreaHectares { get; set; }
        public int? Elevation { get; set; }
        public int StatusId { get; set; }
        public string StatusName { get; set; }
        public string DescriptionRu { get; set; }
        public string HistoricalNames { get; set; }
        public string AlternativeNames { get; set; }
        public long? OKATO { get; set; }
        public long? OKTMO { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}