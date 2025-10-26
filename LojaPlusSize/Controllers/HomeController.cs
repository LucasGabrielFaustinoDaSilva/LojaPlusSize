using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using LojaPlusSize.Data;
using LojaPlusSize.Models;

namespace LojaPlusSize.Controllers
{
    public class HomeController : Controller
    {
        private readonly AppDbContext _context;
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger, AppDbContext context)
        {
            _logger = logger;
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            // Buscar produtos em destaque para a página inicial
            var produtosDestaque = await _context.Produtos
                .Include(p => p.Categoria)
                .Where(p => p.EmEstoque)
                .Take(4)
                .ToListAsync();
                
            return View(produtosDestaque);
        }

        public IActionResult Privacy()
        {
            return View();
        }
    }
}