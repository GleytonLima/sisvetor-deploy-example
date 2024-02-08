docker stop sisvetor-backend
docker exec -it sisvetor-db dropdb -U svuser svprod
docker exec -it sisvetor-db createdb -U svuser svprod
docker exec -it sisvetor-db psql -U svuser -d svprod -c "CREATE EXTENSION IF NOT EXISTS postgis;"
cat svprod.dump | docker exec -i sisvetor-db pg_restore -U svuser -d svprod
docker start sisvetor-backend
