namespace GeographicCatalog.Models
{
    public class RailwayObject
    {
        public int ID_RW { get; set; }
        public DateTime? DATEREG { get; set; }
        public int? ECP { get; set; }
        public string NAMERUS { get; set; }
        public string NAMEBEL { get; set; }
        public string NAMELAT { get; set; }
        public string NAMENORM { get; set; }
        public string CategoryName { get; set; }
        public string CategoryCode { get; set; }
        public string NodeName { get; set; }
        public string RegionName { get; set; }
        public int RegionId { get; set; }
        public string DistrictName { get; set; }
        public int? DistrictId { get; set; }
        public string GEOPR { get; set; }
        public double? X_WGS { get; set; }
        public double? Y_WGS { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string? LocationDescription { get; set; }
        public string NOMENKLAT { get; set; }
        public string UDARRUS { get; set; }
        public string UDARBEL { get; set; }
        public string EXISTENCE { get; set; }
        public string RailwayLine { get; set; }
        public string RailwayCompany { get; set; }
        public int? TracksCount { get; set; }
        public int? PlatformsCount { get; set; }
        public bool IsElectrified { get; set; }
        public bool IsFreight { get; set; }
        public bool IsPassenger { get; set; }
        public bool IsJunction { get; set; }
        public int? Elevation { get; set; }
        public int StatusId { get; set; }
        public string StatusName { get; set; }
        public int? ImportanceCategoryId { get; set; }
        public string ImportanceCategory { get; set; }
        public string DescriptionRu { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
    }
}