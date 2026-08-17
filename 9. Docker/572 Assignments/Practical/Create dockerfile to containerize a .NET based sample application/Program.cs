var builder = WebApplication.CreateBuilder(args);

var app = builder.Build();

app.MapGet("/", () =>
{
    return Results.Ok(new
    {
        message = "Hello from .NET running inside Docker!"
    });
});

app.Run();
