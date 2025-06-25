docker network create roting-network
docker network ls
docker pull postgres:17
docker run \
--name phoenix-db \
--network roting-network \
-e POSTGRES_PASSWORD=postgres \
-e POSTGRES_USER=postgres \
-e POSTGRES_DB=postgres \
-p 5432:5432 \
-v postgres-data:/var/lib/postgresql/data \
-d postgres:17
docker ps
ulimit -n 524288 (wsl2)a
docker exec -it phoenix-db psql -U postgres -d postgres

docker stop phoenix-db
docker rm phoenix-db
docker volume rm postgres-data
docker stop phoenix-db && docker rm phoenix-db && docker volume rm postgres-data


docker ps -a --format "docker rm {{.Name}}"
docker logs -f phoenix-db

 
--name postgres-db: Assigns the name "postgres-db" to the container for easy reference.
 
-e POSTGRES_PASSWORD: Sets the environment variable POSTGRES_PASSWORD to "mypassword", defining the password for the default PostgreSQL user.
 
-e POSTGRES_USER: Sets the environment variable POSTGRES_USER to "myuser", creating a new PostgreSQL user with this name.
 
-e POSTGRES_DB: Sets the environment variable POSTGRES_DB to "mydatabase", creating a new database with this name.
 
-p 5432:5432: Maps port 5432 on the host to port 5432 on the container, allowing external access to the PostgreSQL service.
 
-v postgres-data:/var/lib/postgresql/data: Mounts a Docker volume named "postgres-data" to persist PostgreSQL data at the specified path inside the container.
 
-d postgres: Runs the container in detached mode using the official PostgreSQL image.