using System.Collections.Generic;

namespace GeographicCatalog.Models
{
    public class AdminDashboardViewModel
    {
        public int AteCount { get; set; }
        public int AirportsCount { get; set; }
        public int RailwayCount { get; set; }
        public int FgoCount { get; set; }
        public int TotalCount => AteCount + AirportsCount + RailwayCount + FgoCount;
    }

    public class AdminListViewModel
    {
        public string ObjectType { get; set; }
        public string Title { get; set; }
        public List<AdminListEntry> Items { get; set; } = new List<AdminListEntry>();
        public int Page { get; set; }
        public int TotalCount { get; set; }
        public int PageSize { get; set; }
        public int TotalPages { get; set; }
        public string Search { get; set; }
        public int? RegionId { get; set; }
        public int? DistrictId { get; set; }
        public string SortBy { get; set; }
    }

    public class AdminListEntry
    {
        public int Id { get; set; }
        public string NameRu { get; set; }
        public string NameBe { get; set; }
        public string RegionName { get; set; }
        public string DistrictName { get; set; }
        public string StatusName { get; set; }
    }
}
