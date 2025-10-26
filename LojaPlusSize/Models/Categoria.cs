namespace LojaPlusSize.Models
{
    public class Categoria
    {
        public int Id { get; set; }
        public string? Nome { get; set; }
        public string? Descricao { get; set; }
        public DateTime DataCriacao { get; set; } = DateTime.Now;
        
        // Relacionamento: Uma categoria tem muitos produtos
        public List<Produto>? Produtos { get; set; }
    }
}