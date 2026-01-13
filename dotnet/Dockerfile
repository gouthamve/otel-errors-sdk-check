FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY *.csproj .
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Download and install OpenTelemetry .NET Auto-Instrumentation
ARG OTEL_VERSION=1.7.0
RUN apt-get update && apt-get install -y curl unzip && \
    curl -sSfL https://github.com/open-telemetry/opentelemetry-dotnet-instrumentation/releases/download/v${OTEL_VERSION}/otel-dotnet-auto-install.sh -o otel-dotnet-auto-install.sh && \
    OTEL_DOTNET_AUTO_HOME="/otel-dotnet-auto" sh otel-dotnet-auto-install.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 8080

ENV ASPNETCORE_URLS=http://+:8080

# Source the instrumentation script and run the app
CMD ["/bin/bash", "-c", ". /otel-dotnet-auto/instrument.sh && dotnet dotnet-app.dll"]
