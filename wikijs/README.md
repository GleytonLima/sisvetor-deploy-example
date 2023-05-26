# SisVetor - WikiJS

Este repositório contém a documentação do projeto SisVetor, utilizando a ferramenta WikiJS.

Para subir o WikiJS, execute os seguintes passos:

1. Clone este repositório
2. Acesse a pasta wikijs
3. Crie uma cópia do arquivo `.env.example` com o nome `.env` e preencha as variáveis de ambiente
4. Execute o comando `docker-compose up -d` na pasta raiz do repositório clonado

Por padrão, o WikiJS estará disponível na porta 9993 do servidor.

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