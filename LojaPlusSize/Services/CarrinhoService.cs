using LojaPlusSize.Models;
using System.Text.Json;

namespace LojaPlusSize.Services
{
  public class CarrinhoService
  {
    private const string CarrinhoSessionKey = "Carrinho";
    private readonly IHttpContextAccessor _httpContextAccessor;

    public CarrinhoService(IHttpContextAccessor httpContextAccessor)
    {
      _httpContextAccessor = httpContextAccessor;
    }

    public List<CarrinhoItem> GetCarrinho()
    {
      var session = _httpContextAccessor.HttpContext?.Session;
      var carrinhoJson = session?.GetString(CarrinhoSessionKey);

      if (string.IsNullOrEmpty(carrinhoJson))
        return new List<CarrinhoItem>();

      return JsonSerializer.Deserialize<List<CarrinhoItem>>(carrinhoJson) ?? new List<CarrinhoItem>();
    }

    public void SalvarCarrinho(List<CarrinhoItem> carrinho)
    {
      var session = _httpContextAccessor.HttpContext?.Session;
      var carrinhoJson = JsonSerializer.Serialize(carrinho);
      session?.SetString(CarrinhoSessionKey, carrinhoJson);
    }

    public void AdicionarItem(Produto produto, string tamanho = "P")
    {
      var carrinho = GetCarrinho();
      var itemExistente = carrinho.FirstOrDefault(x => x.ProdutoId == produto.Id && x.Tamanho == tamanho);

      if (itemExistente != null)
      {
        itemExistente.Quantidade++;
      }
      else
      {
        carrinho.Add(new CarrinhoItem
        {
          ProdutoId = produto.Id,
          Nome = produto.Nome,
          Preco = produto.Preco,
          Quantidade = 1,
          Tamanho = tamanho,
          ImagemUrl = produto.ImagemUrl
        });
      }

      SalvarCarrinho(carrinho);
    }

    public void RemoverItem(int produtoId, string tamanho)
    {
      var carrinho = GetCarrinho();
      var item = carrinho.FirstOrDefault(x => x.ProdutoId == produtoId && x.Tamanho == tamanho);

      if (item != null)
      {
        carrinho.Remove(item);
        SalvarCarrinho(carrinho);
      }
    }

    public void AtualizarQuantidade(int produtoId, string tamanho, int quantidade)
    {
      var carrinho = GetCarrinho();
      var item = carrinho.FirstOrDefault(x => x.ProdutoId == produtoId && x.Tamanho == tamanho);

      if (item != null)
      {
        if (quantidade <= 0)
          carrinho.Remove(item);
        else
          item.Quantidade = quantidade;

        SalvarCarrinho(carrinho);
      }
    }

    public decimal GetTotal()
    {
      return GetCarrinho().Sum(x => x.Total);
    }

    public int GetTotalItens()
    {
      return GetCarrinho().Sum(x => x.Quantidade);
    }

    public void LimparCarrinho()
    {
      SalvarCarrinho(new List<CarrinhoItem>());
    }
  }
}