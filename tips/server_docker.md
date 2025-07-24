docker pull
docker run \
--name phoenix-server \
--network roting-network \
-e SECRET_KEY_BASE={mix phx.gen.secret} \
-e DATABASE_URL=ecto://postgres:postgres@phoenix-db/postgres \
-p 4000:4000 \
-d ap95071/rotingtest:latest \
./bin/migrate
docker ps 
docker logs -f phoenix-server
docker exec -it phoenix-server sh

docker stop phoenix-server
docker rm phoenix-server
docker stop phoenix-server && docker rm phoenix-server