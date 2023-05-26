# SisVetor - WikiJS

Este repositório contém a documentação do projeto SisVetor, utilizando a ferramenta WikiJS.

## Gerando backup

Para gerar um backup do WikiJS, execute:

```bash
docker exec wikidb pg_dump wiki -U wikijs -F c > wikibackup.dump
```


## Restaurando backup

Para restaurar um backup do WikiJS, execute:

```bash
docker stop wiki
docker exec -it wikidb dropdb -U wikijs wiki
docker exec -it wikidb createdb -U wikijs wiki
cat wikibackup.dump | docker exec -i wikidb pg_restore -U wikijs -d wiki
docker start wiki
```