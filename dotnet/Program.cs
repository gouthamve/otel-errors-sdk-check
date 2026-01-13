var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello from .NET ASP.NET Core!");

app.MapGet("/throw-error", () => {
    throw new InvalidOperationException("Intentional error from .NET ASP.NET Core application");
});

app.Run();
