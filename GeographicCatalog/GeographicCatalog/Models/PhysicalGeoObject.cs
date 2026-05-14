namespace GeographicCatalog.Models
{
    public class PhysicalGeoObject
    {
        public int ID_FGO { get; set; }
        public string? NAMERUS { get; set; }
        public string? NAMEBEL { get; set; }
        public string? NAMELAT { get; set; }
        public string? NOMENKLAT { get; set; }
        public double? Longitude { get; set; }
        public double? Latitude { get; set; }
        public DateTime? DATEREG { get; set; }
        public string? EXISTENCE { get; set; }
        public string? Description { get; set; } // GEOPR
        public string? Basin { get; set; } // BASRIVER
        public string? Tributary { get; set; } // PRITOK
        public string? FALL { get; set; }
        public double? DISTANCE { get; set; }
        public double? AREA { get; set; }
        public double? DEPTH { get; set; }
        public string? Navigable { get; set; } // SUDOHOD
        public string? SpecialNotes { get; set; } // SPECNOTES
        public string? UDARRUS { get; set; }
        public string? UDARBEL { get; set; }
        public string? RegionName { get; set; }
        public string? TypeName { get; set; } // RFGONAME
        public string? SINFORUS { get; set; }
        public string? SINFOBEL { get; set; }
    }

}