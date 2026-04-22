# 1. Build Stage
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Using [ "source", "destination" ] syntax to force Docker to see the spaces correctly
COPY ["HOLLOW OCTAGONAL PYRAMID CALCULATOR.csproj", "./"]
RUN dotnet restore "HOLLOW OCTAGONAL PYRAMID CALCULATOR.csproj"

# Copy the rest of the source code and build
COPY . .
RUN dotnet build "HOLLOW OCTAGONAL PYRAMID CALCULATOR.csproj" -c Release -o /app/build

# 2. Publish Stage
FROM build AS publish
RUN dotnet publish "HOLLOW OCTAGONAL PYRAMID CALCULATOR.csproj" -c Release -o /app/publish /p:UseAppHost=false

# 3. Runtime Stage
FROM mcr.microsoft.com/dotnet/aspnet:9.0
WORKDIR /app
COPY --from=publish /app/publish .

# Render port binding
ENV ASPNETCORE_URLS=http://+:${PORT:-8080}
EXPOSE 8080

# JSON syntax for entrypoint is also safer
ENTRYPOINT ["dotnet", "HOLLOW OCTAGONAL PYRAMID CALCULATOR.dll"]