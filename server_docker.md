docker pull
docker run \
--name phoenix-server \
--network roting-network \
-e SECRET_KEY_BASE=ndhg+eEhWQe98rDw1xDLr9JsuRd+OU56FhxRSnqpGIwVlqkvkA6YU7ag7ycgp2pS \
-e DATABASE_URL=ecto://postgres:postgres@phoenix-db/postgres \
-p 4000:4000 \
-d ap95071/rotingtest:latest
docker ps 
docker logs -f phoenix-server
docker exec -it phoenix-server sh

docker stop phoenix-server
docker rm phoenix-server
docker stop phoenix-server && docker rm phoenix-server