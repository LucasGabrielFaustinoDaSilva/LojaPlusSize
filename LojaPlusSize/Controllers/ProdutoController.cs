using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using LojaPlusSize.Data;
using LojaPlusSize.Models;

namespace LojaPlusSize.Controllers
{
    public class ProdutoController : Controller
    {
        private readonly AppDbContext _context;

        public ProdutoController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Produto
        public async Task<IActionResult> Index()
        {
            var produtos = await _context.Produtos
                .Include(p => p.Categoria)
                .Where(p => p.EmEstoque)
                .ToListAsync();
            return View(produtos);
        }

        // GET: Produto/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null) return NotFound();

            var produto = await _context.Produtos
                .Include(p => p.Categoria)
                .FirstOrDefaultAsync(m => m.Id == id);
                
            if (produto == null) return NotFound();

            return View(produto);
        }
    }
}