using CreatingKanbanSample.Context;
using CreatingKanbanSample.Data;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.EntityFrameworkCore;
using Syncfusion.Blazor;

Syncfusion.Licensing.SyncfusionLicenseProvider.RegisterLicense("MzUwNjAyMkAzMjM3MmUzMDJlMzBEcG12bi9KS284MlFvR3lSS0tXUFNrbGNZM0JjOHE3eER1YUtKbFNlS3hRPQ==");

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddSyncfusionBlazor();
builder.Services.AddScoped<ToDoService>();

//Connection untuk ke DB SQL Server
builder.Services.AddDbContext<ApplicationDbContext>(item=>item.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();
