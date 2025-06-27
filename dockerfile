# Etapa de build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copiamos los archivos del proyecto
COPY . ./

# Restauramos dependencias
RUN dotnet restore "WaveArg.csproj"

# Compilamos en modo Release
RUN dotnet publish "WaveArg.csproj" -c Release -o /app/publish

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app

# Copiamos la app publicada
COPY --from=build /app/publish .

# Puerto expuesto (opcional)
EXPOSE 80

# Ejecutamos la app
ENTRYPOINT ["dotnet", "WaveArg.dll"]