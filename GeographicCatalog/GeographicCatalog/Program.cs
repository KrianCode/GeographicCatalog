using GeographicCatalog.Models;
using Microsoft.EntityFrameworkCore;
using System.Data;
using Npgsql;

System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);

var builder = WebApplication.CreateBuilder(args);

// ˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜ ˜˜˜˜˜˜˜˜˜
builder.Services.AddControllersWithViews();

// ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜ ˜˜˜˜˜˜ (˜˜˜˜ ˜˜˜˜˜˜˜˜˜˜˜ Entity Framework)
// builder.Services.AddDbContext<DatabaseContext>(options =>
//     options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜ ˜ Dapper
builder.Services.AddScoped<IDbConnection>(sp =>
    new NpgsqlConnection(builder.Configuration.GetConnectionString("DefaultConnection")));

// ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜
builder.Services.AddAuthentication(Microsoft.AspNetCore.Authentication.Cookies.CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/Account/Login";
        options.LogoutPath = "/Account/Logout";
        options.ExpireTimeSpan = TimeSpan.FromHours(2);
        options.SlidingExpiration = true;
    });
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

// ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ ILogger
builder.Services.AddLogging();

var app = builder.Build();

// ˜˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜˜ HTTP ˜˜˜˜˜˜˜˜
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}
else
{
    app.UseDeveloperExceptionPage();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.UseSession();

app.MapControllers();

//˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜ ˜˜˜ Catalog
app.MapControllerRoute(
    name: "catalog",
    pattern: "Catalog/{action=Index}/{id?}",
    defaults: new { controller = "Catalog" });

// ˜˜˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜˜ ˜˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜˜˜˜˜
app.MapControllerRoute(
    name: "ate-details",
    pattern: "Catalog/ATE/{id:int}",
    defaults: new { controller = "Catalog", action = "DetailsATE" });

app.MapControllerRoute(
    name: "air-details",
    pattern: "Catalog/Airport/{id:int}",
    defaults: new { controller = "Catalog", action = "DetailsAirport" });

app.MapControllerRoute(
    name: "rw-details",
    pattern: "Catalog/Railway/{id:int}",
    defaults: new { controller = "Catalog", action = "DetailsRailway" });

app.MapControllerRoute(
    name: "fgo-details",
    pattern: "Catalog/FGO/{id:int}",
    defaults: new { controller = "Catalog", action = "DetailsPhysicalGeo" });

// ˜˜˜˜˜˜˜ ˜˜ ˜˜˜˜˜˜˜˜˜ ˜˜˜ Home
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

// API ˜˜˜˜˜˜˜˜
app.MapControllerRoute(
    name: "api",
    pattern: "api/{controller=Home}/{action=Index}/{id?}");

app.Run();