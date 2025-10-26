using Microsoft.EntityFrameworkCore;
using LojaPlusSize.Data;
using LojaPlusSize.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

// Configurar MySQL
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseMySql(connectionString, ServerVersion.AutoDetect(connectionString)));

// Configurar Session
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
    options.Cookie.Name = "BellaPlus.Session";
});

// Registrar CarrinhoService
builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<CarrinhoService>();

// Configurar logging para debug
builder.Logging.ClearProviders();
builder.Logging.AddConsole();
builder.Logging.AddDebug();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}
else
{
    // Em desenvolvimento, mostra erros detalhados
    app.UseDeveloperExceptionPage();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

// IMPORTANTE: Session deve vir após UseRouting e antes de UseEndpoints
app.UseSession();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

// Rota para detalhes do produto
app.MapControllerRoute(
    name: "produto-details",
    pattern: "Produto/Details/{id}",
    defaults: new { controller = "Produto", action = "Details" });

// Rota para carrinho
app.MapControllerRoute(
    name: "carrinho",
    pattern: "Carrinho/{action=Index}",
    defaults: new { controller = "Carrinho" });

// Rota para conta
app.MapControllerRoute(
    name: "conta",
    pattern: "Conta/{action=Index}",
    defaults: new { controller = "Conta" });

// Middleware para tratar erros 404
app.Use(async (context, next) =>
{
    await next();
    if (context.Response.StatusCode == 404)
    {
        context.Request.Path = "/Home/Error";
        await next();
    }
});

// Criar banco de dados automaticamente (apenas em desenvolvimento)
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    try
    {
        var context = services.GetRequiredService<AppDbContext>();
        // Garantir que o banco seja criado
        context.Database.EnsureCreated();
        
        // Log para debug
        var logger = services.GetRequiredService<ILogger<Program>>();
        logger.LogInformation("Banco de dados verificado/criado com sucesso");
    }
    catch (Exception ex)
    {
        var logger = services.GetRequiredService<ILogger<Program>>();
        logger.LogError(ex, "Erro ao criar o banco de dados");
    }
}

app.Run();