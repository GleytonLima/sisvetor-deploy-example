docker stop sisvetor-backend
docker exec -it sisvetor-db dropdb -U postgres svprod
docker exec -it sisvetor-db createdb -U postgres svprod
docker exec -it sisvetor-db psql -U postgres -d svprod -c "CREATE EXTENSION IF NOT EXISTS postgis;"
cat svprod.dump | docker exec -i sisvetor-db pg_restore -U postgres -d svprod
docker start sisvetor-backend
