namespace LojaPlusSize.Models
{
    public class CarrinhoItem
    {
        public int ProdutoId { get; set; }
        public string? Nome { get; set; }
        public decimal Preco { get; set; }
        public int Quantidade { get; set; }
        public string? Tamanho { get; set; }
        public string? ImagemUrl { get; set; }
        
        public decimal Total => Preco * Quantidade;
    }
}