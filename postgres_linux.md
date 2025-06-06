1. sudo servce postgres stop version
1. sudo apt list --installed | grep postgres -> check if postgresql-version exist
2. sudo apt-get remove postgresql-version
3. sudo rm -r -f /var/lib/postgresql
4. sudo rm -r -f /etc/postgresql
5. sudo apt-get install postgresql-17
6. sudo service postgresql start -> see * No PostgreSQL clusters exist; see "man pg_createcluster"
6. sudo pg_createcluster 17 main --start -> see 17  main    5432 online postgres /var/lib/postgresql/17/main /var/log/postgresql/postgresql-17-main.log
7. sudo service postgresql start
8. psql -> psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  role "XXXXXXX" does not exist
9. psql -U postgres -> psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  Peer authentication failed for user "postgres"
10. "Database administrative login by Unix domain socket" change method from peer to md5 -> sudo nano /etc/postgresql/17/main/pg_hba.conf
11. sudo -i -u postgres -> change to user postgres
12. psql -> enter the postgres cli
13. SQL: /password postgres set the passward "postgres" to user postgres
14. sudo service postgresql restart
15. sudo service postgresql status -> 17/main (port 5432): online
16. psql -U postgres -> passward = "postgres" in step 13


    field :tag, :string
    field :title, :string
    field :category, :string
    field :content, :string
    field :created_at, :string
    field :description, :string

Create api
1. use `mix phx.gen.json [context name] [module name] [schema table name] [columename:type...]`
2. use `mix ecto.create` create database with config in config/dev.exs and stuct filed with settings in lib/[project name]/[module name]/[schema table name].ex
3. use `mix ecto.gen.migration [user_input]` generate a migration file for log the database migrations in sequence
4. edit databse change in priv/repo/migrations/date_user_input.exs
5. use `mix ecto.migrate` to migrate the database

Test api
1. list all posts -> GET
curl -i GET http://localhost:4000/api/posts
2. create a post -> POST
curl -iX POST http://localhost:4000/api/posts \
   -H 'Content-Type: application/json' \
   -d '{"data": {
        "tag": "tag",
        "title": "title",
        "category": "category",
        "content": "content",
        "created_at": "created_at",
        "description": "description"
    }}'
3. read a post -> GET
curl -i GET http://localhost:4000/api/posts/id
4. update a post -> PUT
curl -iX PUT http://localhost:4000/api/posts/id \
   -H 'Content-Type: application/json' \
   -d '{"data": {
        "tag": "tag",
        "title": "title",
        "category": "category",
        "content": "content",
        "created_at": "created_at",
        "description": "description"
    }}'
5. delete a post -> DELETE
curl -iX DELETE http://localhost:4000/api/posts/id \
   -H 'Content-Type: application/json'


curl -i http://localhost:4000/api/posts -> list all posts
curl -i http://localhost:4000/api/posts/id -> list id-th post

login to database and check the created result
sh: psql -U postgres -> passward:postgres
select the database connect to the phoenix
SQL: \c database name
list all tables in the database -> posts, shema_migration
SQL: \dt
list all posts
SQL: SELECT * FROM posts;