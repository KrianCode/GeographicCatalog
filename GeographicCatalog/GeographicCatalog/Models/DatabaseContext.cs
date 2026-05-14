using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;

namespace GeographicCatalog.Models
{
    public class DatabaseContext : DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> options)
            : base(options)
        {
        }

        // Таблицы для чтения (представления)
        public DbSet<AdministrativeUnit> AdministrativeUnits { get; set; }
        public DbSet<Airport> Airports { get; set; }
        public DbSet<RailwayObject> RailwayObjects { get; set; }
        public DbSet<PhysicalGeoObject> PhysicalGeoObjects { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // Настройка представлений
            modelBuilder.Entity<AdministrativeUnit>().ToView("vw_AdministrativeUnits").HasNoKey();
            modelBuilder.Entity<Airport>().ToView("vw_Airports").HasNoKey();
            modelBuilder.Entity<RailwayObject>().ToView("vw_RailwayObjects").HasNoKey();
            modelBuilder.Entity<PhysicalGeoObject>().ToView("vw_PhysicalGeoObjects").HasNoKey();
        }
    }
}