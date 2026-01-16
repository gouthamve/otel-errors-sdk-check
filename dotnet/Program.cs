var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello from .NET ASP.NET Core!");

app.MapGet("/throw-error", () => {
    throw new InvalidOperationException("Intentional error from .NET ASP.NET Core application");
});

app.MapGet("/manual-error", (ILogger<Program> logger) => {
    try
    {
        throw new InvalidOperationException("Intentional error from .NET ASP.NET Core application");
    }
    catch (InvalidOperationException e)
    {
        // that's similar to how ASP.NET logs controller errors
        logger.LogError(e, "Caught an intentional error");
        return "we handled the error";
    }
});


app.Run();
