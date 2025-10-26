namespace LojaPlusSize.Models
{
    public class Produto
    {
        public int Id { get; set; }
        public string? Nome { get; set; }
        public string? Descricao { get; set; }
        public decimal Preco { get; set; }
        public string? TamanhosDisponiveis { get; set; }
        public int CategoriaId { get; set; }
        public string? ImagemUrl { get; set; }
        public bool EmEstoque { get; set; } = true;
        public DateTime DataCriacao { get; set; } = DateTime.Now;
        
        // Relacionamento: Um produto pertence a uma categoria
        public Categoria? Categoria { get; set; }
    }
}