#https://github.com/dotnet/dotnet-docker/blob/main/samples/aspnetapp/Dockerfile.windowsservercore-x64
FROM mcr.microsoft.com/windows:20H2 AS build
WORKDIR /source

#https://github.com/dotnet/dotnet-docker/tree/main/samples/aspnetapp

# copy csproj and restore as distinct layers
#COPY *.sln .
#COPY *.csproj .

# copy everything else and build app
COPY . .

RUN dotnet restore -r win-x64

RUN dotnet publish -c release -o /app -r win-x64 --self-contained false --no-restore

# final stage/image
FROM mcr.microsoft.com/windows:20H2 AS runtime
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["docker-window-server-core"]
