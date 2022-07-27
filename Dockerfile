FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base

WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS publish
WORKDIR /src 

COPY . .

RUN dotnet restore "docker-window-server-core.csproj" 

RUN dotnet publish "docker-window-server-core.csproj" -c Release /app/publish

FROM base AS final
WORKDIR /app

COPY --from=publish /app/publish .

EXPOSE 443
EXPOSE 80 

CMD ["dotnet", "docker-window-server-core.dll"]