namespace GeographicCatalog.Models
{
    public class Airport
    {
        public int ID_AIR { get; set; }
        public DateTime? DATEREG { get; set; }
        public string NAMERUS { get; set; }
        public string NAMEBEL { get; set; }
        public string NAMELAT { get; set; }
        public string CATEGORY { get; set; }
        public string AirportTypeName { get; set; }
        public string RegionName { get; set; }
        public int RegionId { get; set; }
        public string DistrictName { get; set; }
        public int? DistrictId { get; set; }
        public string GEOPR { get; set; }
        public string NOMENKLAT { get; set; }
        public double? X_WGS { get; set; }
        public double? Y_WGS { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        public string UDARRUS { get; set; }
        public string UDARBEL { get; set; }
        public string IATA_Code { get; set; }
        public string ICAO_Code { get; set; }
        public int? AirportTypeId { get; set; }
        public int? RunwaysCount { get; set; }
        public int? LongestRunway { get; set; }
        public int? ElevationFeet { get; set; }
        public string? LocationDescription { get; set; }
        public int? PassengersYearly { get; set; }
        public bool IsInternational { get; set; }
        public bool HasCustoms { get; set; }
        public bool IsMilitary { get; set; }
        public int StatusId { get; set; }
        public string StatusName { get; set; }
        public string Website { get; set; }
        public string ContactPhone { get; set; }
        public string DescriptionRu { get; set; }
        public DateTime CreatedDate { get; set; }
        public DateTime ModifiedDate { get; set; }
    }

}