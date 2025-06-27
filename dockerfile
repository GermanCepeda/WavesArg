# Etapa 1: build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copiamos todo el repo
COPY . .

# Restauramos y publicamos desde la subcarpeta
WORKDIR /src/WaveArg
RUN dotnet restore "WaveArg/WaveArg.csproj"
RUN dotnet publish "WaveArg/WaveArg.csproj" -c Release -o /app/publish

# Etapa 2: runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app/publish .

EXPOSE 80
ENTRYPOINT ["dotnet", "WaveArg.dll"]