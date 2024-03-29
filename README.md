# Reforço Backend

Abaixo eu fiz um guia para conseguir criar uma API Restful com C# e MySQL, para acessá-la utiliza-se o fetch no JavaScript, variando de linguagem para linguagem.
> Esse documento não é engessado, qualquer sugestão melhoria ou erro só me informar que atualizo o documento.

# Guia de Configuração de API REST C# + MySQL

Material montado com o intuio de mostrar um passo a passo de como configurar um _backend_ simples de .NET C# + MySQL.

## Dependências

Para seguir esse guia é necessário ter um conhecimento básico de .NET C#, seguindo os conteúdos apresentados em PC I com aplicações via console, no curso de Informática da ETEC Adolpho Berezin.
Abaixo vou listar o que será necessário para realizar o que estiver sendo apresentado neste guia:

- Interface de Desenvovimento (IDE): Como a API será desenvolvida com .NET C# recomenda-se o [Visual Studio Code](https://code.visualstudio.com/) ou o [Visual Studio Community](https://visualstudio.microsoft.com/pt-br/);
- [.NET 8.0](https://dotnet.microsoft.com/pt-br/download) ou versão mais atual disponível;
- Banco de Dados [MySQL Community](https://github.com/ermogenes/aulas-programacao-web/blob/master/content/ambiente-mysql.md);
- [Git](https://git-scm.com/downloads) caso queira subir para o GitHub, por exemplo;
- Força de vontade 😊
 
_OBS: Mais informações seguir os conteúdos disponiblizados no repositório do curso no GitHub, por [aqui](https://github.com/vinicioslop/aulas-programacao-web?tab=readme-ov-file#-ferramentas)._

## Configurando o projeto

### Banco de Dados de Referência

Para dar seguimento na criação do projeto é necessário o MySQL instalado e funcionando em sua máquina com um banco de dados criado, não necessariamente populado, mas ajuda bastante. Pode ser utilizado o banco do seu TCC, por exemplo, mas nesse guia iremos utilizar o banco Livraria, de uma das atividades de Suporte a Banco de Dados.

Disponibilizarei o código abaixo caso tenham interesse em seguir por ele e adaptar futuramente:
~~~sql
create database db_livraria;

use db_livraria;

create table tb_autor(
	id_autor int primary key,
	nome varchar(45),
	nr_fone varchar(15),
	pais varchar(45)
);

create table tb_categoria(
	id_categoria int primary key,
	nm_categoria varchar(45),
	ds_categoria varchar(150)
);

create table tb_livro(
	id_livro int primary key,
	titulo varchar(45),
	ano year,
	ds_livro varchar(100),
	fk_idautor int,
	fk_idcategoria int,
	foreign key (fk_idcategoria) references tb_categoria (id_categoria),
	foreign key (fk_idautor) references tb_autor (id_autor)
);

-- Registro Autores
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (001, 'Takehiko Inoue', 'Japao', 59867537);
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (002, 'Machado de Assis', 'Brasil', 90347633);
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (003, 'Antoine de Saint-Exupery', 'França', 02745362);
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (004, 'J. K. Rowling', 'Reino Unido', 74739478);
insert into tb_autor(id_autor, nome, pais, nr_fone)
values (005, 'Inio Asano', 'Japao', 02393746);
 
-- Registro Categorias
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (001, 'Drama', 'Uma historia dramatica');
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (002, 'Ficcao', 'Fuja da realidade');
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (003, 'Fabula', 'Historias infantis');
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (004, 'Aventura', 'Conheça novos lugar');
insert into tb_categoria(id_categoria, nm_categoria, ds_categoria)
values (005, 'Romance e suspense', 'Uma trama');

-- Registro Livros
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (001, 'Vagabond', 'Uma historia dramatica','1998', 001, 001);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (002, 'O Alienista', 'Fuja da realidade', '1982', 002, 002);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (003, 'O Pequeno Príncipe', 'Historias infantis', '1943', 003, 003);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (004, 'Harry Potter', 'Conheça novos lugar', '1997', 004, 004);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (005, 'Boa Noite Punpun', 'Uma trama','2007', 005, 005);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (006, 'Sense Life', 'Conheça novos lugar','2020', 004, 004);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (007, 'Mob Psycho 100', 'Fuja da realidade','2012', 002, 002);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (008, 'A Girl on the Shore Collectors Edition', 'Uma trama','2023', 005, 005);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (009, 'Dom Quixote', 'Historias infantis','1999', 003, 003);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (010, 'Dead Dead Demons de Dedede Destruction', 'Ficcao','2014', 002, 002);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (011, 'Chainsaw Man', 'Aventura','2022', 004, 004);
insert into tb_livro(id_livro, titulo, ds_livro, ano, fk_idautor, fk_idcategoria)
values (012, 'Jujutsu Kaisen', 'Aventura','2018', 004, 004);
~~~

### Criando a aplicação .NET C#
Com o banco de dados criado e rodando em sua máquina iremos criar o projeto .NET C# através de linha de comando. Na pasta seleciona, ou repositório clonado do GitHub inicie um proketo no formato web seguindo o seguinte comando:

~~~pwsh
dotnet new web -o NOME_DO_PROJETO
~~~

No caso do guia com o seguinte nome:

~~~pwsh
dotnet new web -o api_livraria
~~~

O comando acima irá criar um projeto no formato `web`, ou seja, um programa que rodará como uma API e acessado através de uma URL. A flag `-o` é utilizada para definir um nome para o projeto, criando uma pasta com esse nome informado.
Caso a flag não seja informada irá criar os arquivos do projeto na pasta atual, podendo poluir o projeto. Exemplo: se for executado o comando `dotnet new web` na área de trabalho irá criar o projeto com o nome 'Desktop' ou 'Área de Trabalho'.

### Acessando o Projeto criado
Após a criação do projeto acessá-la e abrir ela na IDE de sua escolha, como o Visual Studio Code, por exemplo, seguindo o seguinte comando:
~~~pwsh
code . -r
~~~
A estrutura criada será a seguinte:
~~~csharp
var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.Run();
~~~
É possível executar o projeto e verificar se está funcionando corretamente, com o comando:
~~~pwsh
dotnet run
~~~
Após o projeto rodar e baixar todas as dependências de execução irá aprentar uma url para acessar o projeto, a copiando e colocando no navegador de sua escolha, ou no Windows pressionando o `ctrl + 'clique esquerdo do mouse'` irá abrir o projeto no navegador retornando a mensagem `Hello World!`, mensagem configurado na rota padrão do projeto.

### Rotas da API Rest
API Rest é um programa onde não é acessado via uma página web, como um site, mas através do que chamados de rotas. Essas rotas são _urls_ que são configuradas para realizar alguma ação ou retornar algum tipo de dado.

Exemplo de uma rota para retorno de clientes de um determinado banco: `https://siteapi.com/api/clientes/`, quando acessar essa _url_ através de um navegador irá retornar uma lista de cliente, com os dados configurados em relação a eles.

Outra maneira seria através do `fetch` do JavaScript, onde podem ver um pouco mais sobre ele pelo conteúdo disponível [aqui](https://github.com/vinicioslop/aulas-programacao-web/blob/master/content/async-fetch.md).

### Configurando dependências de projeto
Com o projeto criado e funcionando iremos configurar com alguns pacotes responsaveis pela manipulação de banco de dados, são eles:

- Entify Framework (EF);
- Pomelo;

Para adicioná-los ao projeto acessaremos o nosso programa via terminal e executar os seguintes comando, primeiro para adicionar o Entity Framework:
~~~pwsh
dotnet add package Microsoft.EntityFrameworkCore
dotnet add package Microsoft.EntityFrameworkCore.Design
~~~
Após executar os comandos acima adicionaremos o Pomelo, com:
~~~pwsh
dotnet add package Pomelo.EntityFrameworkCore.MySql
~~~

### Outros pacotes
Podemos adicionar o pacote do `swagger`, que irá nos entregar uma interface gráfica para interagirmos e testarmos nossa aplicação.
Para adicionarmos o `swagger` utilizamos o seguinte comando:
~~~pwsh
dotnet add package Swashbuckle.AspNetCore
~~~

### Realizar o Scaffolding
Essa etapa é responsavel por fazer que o Entity Framework faça o mapeamento do banco de dados selecionado e o transforme em um grupo de objetos, cada um referente a uma tavela e um chamado de **contexto**, responsável por fazer o relacionamento entre os objetos criados, criação de chaves primárias, configuração de caracteres máximos, tudo que foi definido na criação do banco de dados.
Para executar esse processo sera feito o seguinte comando via terminal:
~~~pwsh
dotnet ef dbcontext scaffold "server=___;port=___;user=___;password=___;database=___" Pomelo.EntityFrameworkCore.MySql -o ___ -f --no-pluralize
~~~

Onde:
- Em `server` passe o endereço do servidor (ex.: localhost);
- Em `port` passe a porta do servidor (ex.: 3306);
- Em `user` e password passe o seu usuário e senha;
- Em `database` passe o nome do banco (ex.: employees);
- Em `-o` indique a pasta onde as classes serão criadas;
- Em `--no-pluralize` evitar que o Entity Framework coloque as classes no sem tentar gerar plurais automaticamente. É especialmente útil quando o banco foi modelado com termos em português.

Nesse guia executaremos o comando da seguinte forma:
~~~pwsh
dotnet ef dbcontext scaffold "server=localhost;port=3306;user=root;password=root;database=db_livraria" Pomelo.EntityFrameworkCore.MySql -o db -f --no-pluralize
~~~

Após executar o comando o Entity Framework irá criar a estrutura do banco de dados em formato de classes na pasta com o nome definido, no caso `db`.

### Aplicando Pacotes no Projeto
Depois de adicionar os pacotes via terminal precisamos os configurar no código do projeto, dentro de `Program.cs`, ficando dessa forma:
~~~csharp
using Swashbuckle.AspNetCore;
...
builder.Services.AddSwaggerGen();
builder.Services.AddEndpointsApiExplorer();
...
app.UseSwagger();
app.UseSwaggerUI();
...
~~~

Onde:
- `using Swashbuckle.AspNetCore;` precisa ficar no começo do código;
- `builder.Services...` precisa ficar após a criação da variável `builder`;
- Configurações do `swagger` após a definição da variável `app`.

No projeto utilizando o banco de dados de livraria como referência ficaria da seguinte forma:
~~~chsarp
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Swashbuckle.AspNetCore;
using api_livraria.db;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSwaggerGen();
builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();

app.UseHttpsRedirection();
app.UseSwagger();
app.UseSwaggerUI();

app.MapGet("/", () => "Hello World!");

app.Run();
~~~


### Configuração de Rotas com conexão ao Banco de Dados

Com a estrutura montada seguindo o conteúdo apresentado faltaria a configuração das rotas com conexão ao banco de dados. Será feito com base no banco de dados de livraria, mas com poucas alterações é adaptável a qualquer banco configurado corretamente.

### STATUS CODE ou Códigos de Retorno
Os códigos de status seguem uma tabela numérica, com o seguinte agrupamento:

- Respostas de informação (100-199)
- Respostas de sucesso (200-299)
- Redirecionamentos (300-399)
- Erros do cliente (400-499)
- Erros do servidor (500-599)

Por exemplo:
- 200 OK caso a solicitação seja válida e o resultado seja enviado com sucesso
- 404 NOT FOUND caso o recurso não exista
- 400 BAD REQUEST caso a solicitação seja inválida (por erro do cliente)
- 500 INTERNAL SERVER ERROR caso ocorra um problema (por erro do servidor)

Veja uma tabela completa [aqui](https://developer.mozilla.org/pt-BR/docs/Web/HTTP/Status) Veja também 🐱 [aqui](flickr.com/photos/girliemac/albums/72157628409467125/) e 🐶 [aqui](https://httpstatusdogs.com/).

#### RETURN ou Retorno de Dados do Banco
Para criar uma rota que retorne os dados de uma tabela específica, ou de um conjunto de tabelas pode ser feito seguindo o código abaixo:
~~~chsarp
app.MapGet("/api/autores", ([FromServices] DbLivrariaContext _db,
) =>
{
    var query = _db.TbAutor.AsQueryable<TbAutor>();
    var autores = query.ToList<TbAutor>();
    return Results.Ok(autores);
});
~~~
> O código acima retorna todos os dados presentes na tabela de autores, a partir da url da rota definida. Se o programa estiver rodando na máquina local ao acessar `https://localhost:5126/api/autores` irá retornar uma lista dessas informações em forma _json_.

Posso por exemplo alterar essa rota para invés de retornar uma lista com vários dados receber um dado único, fazendo da seguinte forma:
~~~csharp
app.MapGet("/api/autor/{id}", ([FromServices] DbLivrariaContext _db,
    [FromRoute] int id
) => {
    var autor = _db.TbAutor.Find(id);

    if (autor == null) {
        return Results.NotFound();
    }

    return Results.Ok(autor);
});
~~~
> O código acima retorna um item da tabela de autores a partir do `id` informado, a partir da url da rota definida. Se o programa estiver rodando na máquina local ao acessar `https://localhost:5126/api/autor/{id}` ou `https://localhost:5126/api/autor/1` irá retornar um item em formato _json_, no caso a segunda _url_ irá retornar os dados de autor com o `id = 1`, caso não exista irá retornar como vazio, já que não existe.

É possível ainda receber dados opcionais para fazer essa busca a partir de um filtro, como no caso de autores o nome. Para isso podemos fazer da seguinte forma:
~~~csharp
app.MapGet("/api/autores/filtro", ([FromServices] DbLivrariaContext _db,
    [FromQuery] string? nome) =>
    {
        var query = _db.TbAutor.AsQueryable<TbAutor>();

        if (!String.IsNullOrEmpty(nome)) {
            query = query.Where(a => a.Nome.Contains(nome));
        }

        var autores = query.ToList<TbAutor>();

        return Results.Ok(autores);
});
~~~
> Esse código seria uma variação da rota de autores com filtro, foi nomeada como `https://localhost:5126/api/autores/filtro` para não dar conflito com a rota de autores, caso seja alterada a rota para a mesma da principal funcionaria normalmente. Nesse caso o dado da `nome` como possuí uma `?` após o tipo da variável informa que esse dado é opcional e não precisaria ser informada para a utilização da rota, retornando dados em que o texto informada possua alguma semelhança com o que foi comparado, mas não sendo obrigatório ser igual.

#### CREATE ou Novo Item na Tabela
Para criar uma rota para adicionar um novo item dentro de uma tabela específica pode ser feito da seguinte forma:
~~~csharp
app.MapPost("/api/autor", ([FromServices] DbLivrariaContext _db,
    [FromBody] TbAutor novoAutor
) =>
{
    if (String.IsNullOrEmpty(novoAutor.Nome))
    {
        return Results.BadRequest(new { mensagem = "Não é possivel incluir um autor sem nome." });
    }

    var autor = new TbAutor
    {
        Nome = novoAutor.Nome,
        Pais = novoAutor.Pais,
        NrFone = novoAutor.NrFone
    };

    _db.TbAutor.Add(autor);
    _db.SaveChanges();

    var autorUrl = $"/api/autor/{autor.IdAutor}";

    return Results.Created(autorUrl, autor);
});
~~~
> No código acima irá criar um novo autor com base nos dados enviados através do corpo da requisição, onde ele irá receber os dados e identificar se o nome foi informado, caso não seja retornará um aviso informando que esse dado precisa ser informado. Se todas as informações forem enviadas corretamente ele cria um novo objeto no formato configurado pelo scaffold e adiciona ao banco de dados na tabela de autor.

#### PUT ou Atualizar um recurso Completo
Para realizar alterações em algum autor, por exemplo, pode ser utilizado o PUT, ele irá receber as informações informadas no corpo da requisição e alterar o dado como um todo. Para isso pode ser feito da seguinte manteira:
~~~csharp
app.MapPut("/api/autor/{id}", ([FromServices] DbLivrariaContext _db,
    [FromRoute] int id,
    [FromBody] TbAutor autorAlterado
) =>
{
    if (autorAlterado.IdAutor != id)
    {
        return Results.BadRequest(new { mensagem = "Id inconsistente." });
    }

    if (String.IsNullOrEmpty(autorAlterado.Nome))
    {
        return Results.BadRequest(new { mensagem = "Não é permitido deixar um autor sem nome." });
    }

    var autor = _db.TbAutor.Find(id);

    if (autor == null)
    {
        return Results.NotFound();
    }

    autor.Nome = autorAlterado.Nome;
    autor.Pais = autorAlterado.Pais;
    autor.NrFone = autorAlterado.NrFone;

    _db.SaveChanges();

    return Results.Ok(autor);
});
~~~
> Utilizando o método PUT no código acima irá receber os dados novos para realizar alguma edição do mesmo, no caso de autor, ele vai receber os dados no corpo da requisição e o `id` desse autor na url, procurar esse autor no banco de dados para confirmar se o mesmo existe. Caso não exista ele irá retornar que não encontrou o dado com um status de 404, existindo irá atribuir os dados ao autor retornado no banco e salvar as alterações fazendo a atualização.
> OBS: Vale ressaltar que o PUT altera todos os dados de um item de uma tabela, nesse caso é importante fazer uma verificação para confirmar se todos os dados foram informados, para não ter a perda de dados. Outra maneira seria verificar e comparar quais dados foram enviados e alterar apenas estes, nesse caso o próximo método seria mais interessante para esse tipo de alteração.

### DELETE ou Remoção de dado da tabela
A última rota desse conjunto do CRUD seria o delete, ou remoção. Será informado um `id` através da `url` ou do corpo da requisição, procurar esse dado no banco, existindo realizar a exclusão desse dado.
Podemos ver como funciona com o código abaixo:
~~~csharp
app.MapDelete("/api/autores/{id}", ([FromServices] DbLivrariaContext _db,
    [FromRoute] int id
) =>
{
    var autor = _db.TbAutor.Find(id);

    if (autor == null)
    {
        return Results.NotFound();
    }

    _db.TbAutor.Remove(autor);
    _db.SaveChanges();

    return Results.Ok();
});
~~~
> Semelhante a rota de retorno de autor único a partir do `id`, irá receber esse dado através da `url`, ou do corpo da requisição caso ache necessário, procurar esse autor no banco em sua respectiva tabela, caso não encontre irá retornar um status 404. Encontrando esse dado ele irá remover da tabela e salvar as alterações, ao final retornando um status 200, que informa que tudo ocorreu como planejado.
