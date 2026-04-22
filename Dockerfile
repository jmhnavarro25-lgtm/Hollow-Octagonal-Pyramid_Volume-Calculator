# 1. Build Stage - Changed to 10.0
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /src

COPY ["HOLLOW OCTAGONAL PYRAMID CALCULATOR.csproj", "./"]
RUN dotnet restore "HOLLOW OCTAGONAL PYRAMID CALCULATOR.csproj"

COPY . .
RUN dotnet build "HOLLOW OCTAGONAL PYRAMID CALCULATOR.csproj" -c Release -o /app/build

# 2. Publish Stage
FROM build AS publish
RUN dotnet publish "HOLLOW OCTAGONAL PYRAMID CALCULATOR.csproj" -c Release -o /app/publish /p:UseAppHost=false

# 3. Runtime Stage - Changed to 10.0
FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=publish /app/publish .

ENV ASPNETCORE_URLS=http://+:${PORT:-8080}
EXPOSE 8080

ENTRYPOINT ["dotnet", "HOLLOW OCTAGONAL PYRAMID CALCULATOR.dll"]
