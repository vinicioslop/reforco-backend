using Swashbuckle.AspNetCore;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Mvc;

using reforco.db;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSwaggerGen();
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddDbContext<DbLivrariaContext>(opt =>
{
    string connectionString = builder.Configuration.GetConnectionString("livrariaConnection");
    var serverVersion = ServerVersion.AutoDetect(connectionString);
    opt.UseMySql(connectionString, serverVersion);
});

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();

app.MapGet("/api/autores", ([FromServices] DbLivrariaContext _db) =>
{
    return Results.Ok(_db.TbAutor.ToList<TbAutor>());
});

app.MapPost("/api/autores", ([FromServices] DbLivrariaContext _db,
    [FromBody] TbAutor novoAutor
) =>
{
    var autor = new TbAutor
    {
        IdAutor = novoAutor.IdAutor,
        Nome = novoAutor.Nome,
        NrFone = novoAutor.NrFone,
        Pais = novoAutor.Pais,
    };

    _db.TbAutor.Add(autor);
    _db.SaveChanges();

    var autorUrl = $"/api/autores/{autor.IdAutor}";

    return Results.Created(autorUrl, autor);
});

app.Run();
