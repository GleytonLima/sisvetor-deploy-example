# SisVetor - Exemplo Básico de Uso em Ambientes On Premisses

O SisVetor é um sistema que permite a criação de formulários e a coleta de dados em campo,
com ou sem conexão com a internet. Os dados coletados podem ser enviados para um servidor central, onde podem ser visualizados e analisados.

Este é um exemplo de uso do SisVetor em ambientes On Premisses de forma simplificada, utilizando o Docker para a criação de um ambiente de desenvolvimento e vitrine.

Vale ressaltar que uma solução mais robusta e escalável pode ser obtida utilizando o SisVetor em conjunto com
tecnologias como Kubernetes e Google Cloud Platform ou Amazon Web Services, dado que os componentes do SisVetor rodam em containers Docker.

## Requisitos

Para instalar o SisVetor as seguintes pré-condições devem ser atendidas:

- Docker instalado e configurado
- Docker Compose instalado e configurado
- Git instalado e configurado
- Acesso à internet
- Acesso a este repositório
- No mínimo 8GB de memória RAM disponível
- No mínimo 10GB de espaço em disco disponível
- No mínimo 2 cores de CPU disponíveis

Vale ressaltar que em um ambiente onpromisses, deve ser configurado um servidor proxy reverso para o SisVetor App e o SisVetor Admin, de forma que o acesso a estes componentes seja feito através de um endereço DNS.

# Parâmetros de Configuração

Este projeto está divido em 4 (quatro) pastas:

- apps
- db
- db_migrations
- wikijs

## Apps

A pasta apps, possui um arquivo `docker-compose.yml`, responsável por subir as quatro aplicações principais:

1. Sisvetor Admin
2. Sisvetor App
3. Sisvetor Backend
4. Sisvetor Landing

Estas aplicações são parametrizáveis por meio das seguintes variáveis de ambiente, que podem ser definidas no arquivo `.env` na pasta [apps](apps) do repositório clonado.

| Variável                          | Descrição                       |
| --------------------------------- | ------------------------------- |
| POSTGRES_SVUSER                   | Usuário Postgresql              |
| POSTGRES_PASSWORD                 | Senha Postgresql                |
| SPRING_MAIL_HOST                  | Email host smpt.example.com     |
| SPRING_MAIL_USERNAME              | Email user name                 |
| SPRING_MAIL_PASSWORD              | Email senha                     |
| SPRING_MAIL_PORT                  | Email port                      |
| ARBOCONTROL_JWT_SECRET            | JWT Segredo para extratificação |
| ARBOCONTROL_JWT_EXPIRATION_MILLIS | JWT Tempo Expiração             |
| SISVETOR_BACKEND_URL              | URL do servidor backend         |

Além disso, os arquivos `config-sivetor-app.json` e `config-sivetor-landing.json` devem ser atualizados com os dados do seu ambiente.

No arquivo `config-sivetor-app.json`, usados no SisVetor Campo, devem ser atualizados os seguintes parâmetros:

| Parâmetro  | Descrição               |
| ---------- | ----------------------- |
| defaultUrl | URL do servidor backend |

No arquivo `config-sivetor-landing.json`, usados na landing page, devem ser atualizados os seguintes parâmetros:

| Parâmetro          | Descrição                      |
| ------------------ | ------------------------------ |
| sisvetor_home_url  | URL da home da landing page    |
| sisvetor_app_url   | URL do App SPA, SisVetor Campo |
| sisvetor_admin_url | URL do App SisVetor Admin      |
| sisvetor_wiki_url  | URL para o SisVetor Wiki       |

## db

A pasta db, possui um arquivo `docker-compose.yml`, responsável por subir o banco de dados Postgresql.

Este banco de dados é parametrizável por meio das seguintes variáveis de ambiente, que podem ser definidas no arquivo `.env` na pasta [db](db) do repositório clonado.

| Variável          | Descrição              |
| ----------------- | ---------------------- |
| POSTGRES_USER     | Usuário Postgresql     |
| POSTGRES_PASSWORD | Senha Postgresql       |
| POSTGRES_DB       | Nome do banco de dados |

## db_migrations

A pasta db_migrations, possui um arquivo `docker-compose.yml`, responsável por subir um container docker que executa as migrações do banco de dados.

Este container é parametrizável por meio das seguintes variáveis de ambiente, que podem ser definidas no arquivo `.env` na pasta [db_migrations](db_migrations) do repositório clonado.

| Variável          | Descrição             |
| ----------------- | --------------------- |
| POSTGRES_USER     | Usuário Postgresql    |
| POSTGRES_PASSWORD | Senha Postgresql      |
| FLYWAY_DB_URL     | URL do banco de dados |

O flyway é uma ferramenta de migração de banco de dados que permite a execução de scripts SQL em um banco de dados.

Os scripts de migração devem ser colocados na pasta `db_migrations/migrations` do repositório clonado.

Os scripts devem seguir o seguinte padrão de nomenclatura: `V<versão>__<nome>.sql`, onde `<versão>` é um número inteiro que representa a versão do script e `<nome>` é um nome descritivo do script.

## wikijs

A pasta wikijs, possui um arquivo `docker-compose.yml`, responsável por subir a aplicação WikiJS.

Esta aplicação é parametrizável por meio das seguintes variáveis de ambiente, que podem ser definidas no arquivo `.env` na pasta [wikijs](wikijs) do repositório clonado.

| Variável       | Descrição          |
| -------------- | ------------------ |
| WIKIJS_DB_USER | Usuário Postgresql |
| WIKIJS_DB_PASS | Senha Postgresql   |

Há instruções detalhadas sobre a instalação e configuração do WikiJS no arquivo [README.md](wikijs/README.md) na pasta wikijs.

# Componentes

O SisVetor é composto por 6 componentes principais:

- SisVetor App: aplicativo SPA Angular que permite a coleta de dados em campo
- SisVetor Landing: landing page em html, css e javascript com a página inicial do SisVetor
- SisVetor Admin: aplicação web que permite a criação de formulários e a visualização dos dados coletados
- SisVetor Backend: API que permite a comunicação entre o SisVetor App e o SisVetor Admin
- SisVetor WikiJS: wiki que contém a documentação do SisVetor

## Instalação

Para instalar o SisVetor App, Admin, Landing Page, Backend e Banco de Dados, siga os seguintes passos:

1. Clone este repositório
2. Crie uma cópia do arquivo `.env.example` com o nome `.env` e preencha as variáveis de ambiente em cada pasta
3. Atualize os arquivos config-sivetor-app.json e config-sivetor-landing.json com os dados do seu ambiente
4. Dê as permissões necessárias ao arquivo wait-for-it para que possa ser executado: chmod +x /wait-for-it.sh
5. Execute o comando `docker-compose up -d` na pasta raiz de cada pasta na seguinte ordem: db, db_migrations, apps
6. Aguarde a instalação dos componentes do SisVetor
7. Acesse a landing page do SisVetor através do endereço http://localhost:80

Para instalar o SisVetor WikiJS, siga as instruções no arquivo [README.md](wikijs/README.md) na pasta wikijs.

## Reiniciando containers

Para reiniciar um container específico, de forma que ele utilize as configurações atualizadas, execute o comando `docker-compose up -d <nome do container>` na pasta específica do container, por exemplo:

```bash
cd apps
docker-compose up -d sisvetor-backend
```

## Visualizando logs

Para visualizar os logs de um container específico, execute o comando `docker-compose logs -f <nome do container>` na pasta específica do container, por exemplo:

```bash
cd apps
docker-compose logs --tail 100 sisvetor-backend
```

## Atualizando o SisVetor

Para atualizar uma imagem específica do SisVetor, execute o comando `docker-compose pull <nome do container>`=

```bash
cd apps
docker-compose pull sisvetor-backend
```

## Backup e Restauração

Para realizar o backup dos dados do SisVetor, execute o script `backup.sh` na pasta db
Para restaurar os dados do SisVetor, execute o script `restore.sh` na pasta db

## Referências

- Sobre o Docker: https://docs.docker.com/
- Sobre o Docker Compose: https://docs.docker.com/compose/
- Sobre o Git: https://git-scm.com/doc
- Sobre backup e restauração do WikiJS: https://docs.requarks.io/install/transfer
