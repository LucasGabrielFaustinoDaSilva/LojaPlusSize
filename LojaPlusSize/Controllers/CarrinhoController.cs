using Microsoft.AspNetCore.Mvc;
using LojaPlusSize.Models;
using LojaPlusSize.Services;
using LojaPlusSize.Data;

namespace LojaPlusSize.Controllers
{
    public class CarrinhoController : Controller
    {
        private readonly CarrinhoService _carrinhoService;
        private readonly AppDbContext _context;

        public CarrinhoController(CarrinhoService carrinhoService, AppDbContext context)
        {
            _carrinhoService = carrinhoService;
            _context = context;
        }

        public IActionResult Index()
        {
            var carrinho = _carrinhoService.GetCarrinho();
            ViewBag.Total = _carrinhoService.GetTotal();
            return View(carrinho);
        }

        [HttpPost]
        public IActionResult Adicionar(int produtoId, string tamanho = "44")
        {
            var produto = _context.Produtos.FirstOrDefault(p => p.Id == produtoId);
            if (produto == null) return NotFound();

            _carrinhoService.AdicionarItem(produto, tamanho);

            TempData["Sucesso"] = $"{produto.Nome} adicionado ao carrinho!";
            return RedirectToAction("Index");
        }

        [HttpPost]
        public IActionResult Remover(int produtoId, string tamanho)
        {
            _carrinhoService.RemoverItem(produtoId, tamanho);
            TempData["Sucesso"] = "Item removido do carrinho!";
            return RedirectToAction("Index");
        }

        [HttpPost]
        public IActionResult AtualizarQuantidade(int produtoId, string tamanho, int quantidade)
        {
            _carrinhoService.AtualizarQuantidade(produtoId, tamanho, quantidade);
            return RedirectToAction("Index");
        }

        [HttpPost]
        public IActionResult Limpar()
        {
            _carrinhoService.LimparCarrinho();
            TempData["Sucesso"] = "Carrinho limpo!";
            return RedirectToAction("Index");
        }
    }
}