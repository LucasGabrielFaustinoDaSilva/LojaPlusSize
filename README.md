Bella Plus - Loja Plus Size

Projeto acadêmico de uma loja virtual voltada para o público feminino plus size. Desenvolvido em ASP.NET Core MVC com banco de dados MySQL.
O objetivo é praticar os conceitos de CRUD, arquitetura MVC e integração com banco de dados de forma simples.

Características

Design simples e responsivo

Cadastro e listagem de produtos

Carrinho de compras básico

Área do cliente

Banco de dados MySQL conectado

Estrutura MVC completa

Tecnologias Utilizadas

Backend: ASP.NET Core MVC 9.0

Frontend: Bootstrap 5.3

Banco de Dados: MySQL 8.0

ORM: Entity Framework Core

IDE: Visual Studio Code

Ferramentas: MySQL Shell e .NET CLI

Pré-requisitos

Antes de executar o projeto, é necessário ter instalado:

.NET 9.0 SDK

MySQL Server 8.0

MySQL Workbench (opcional)

Visual Studio Code

Instalação e Configuração

Clone ou baixe o projeto:

git clone https://github.com/LucasGabrielFaustinoDaSilva/LojaPlusSize
cd LojaPlusSize


Configure o banco de dados:

Abra o MySQL Workbench ou Shell

Execute o script database/LojaPlusSize_Backup.sql para criar as tabelas

Atualize a conexão no arquivo appsettings.json:

"ConnectionStrings": {
  "DefaultConnection": "Server=localhost;Database=LojaPlusSize;User=root;Password=sua_senha;"
}


Restaure os pacotes NuGet:

dotnet restore


Execute o projeto:

dotnet run


Depois, abra o navegador em:

https://localhost:7000

Estrutura do Banco de Dados

Categorias: tipos de produtos

Produtos: informações e preços

Clientes: cadastro de usuários

Pedidos: histórico básico de compras

Funcionalidades

Página inicial com produtos

Listagem completa de itens

Página de detalhes do produto

Carrinho de compras com sessão

Área do cliente com histórico

Próximas Implementações

Login e autenticação

Checkout completo

Painel administrativo

Avaliações de produtos

Informações Finais

Este projeto foi desenvolvido como trabalho acadêmico para a disciplina de Programação Web do curso de Engenharia da Computação.
Desenvolvido por Lucas Gabriel Faustino da Silva, com ajuda de pesquisas online para aprendizado e prática de desenvolvimento web.
