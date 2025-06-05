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

curl --location --request POST 'http://localhost:4000/api/posts' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data": {
        "tag": "tag",
        "title": "title",
        "category": "category",
        "content": "Ipsum dolor sit amet **consectetur** adipiscing. Leo integer malesuada nunc vel risus. Id leo in vitae turpis massa sed elementum tempus egestas.\n\n- Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus\n- Sed felis eget velit aliquet sagittis id consectetur. Interdum varius sit amet mattis\n- Orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor.\n\n Integer enim neque volutpat ac tincidunt vitae. Ac turpis egestas maecenas pharetra convallis posuere. Urna neque viverra justo nec ultrices dui.",
        "created_at": "created_at",
        "description": "description"
    }
}'

curl -iX POST http://localhost:4000/api/posts \
   -H 'Content-Type: application/json' \
   -d '{"post": {
        "tag": "tag",
        "title": "title",
        "category": "category",
        "content": "Ipsum dolor sit amet **consectetur** adipiscing. Leo integer malesuada nunc vel risus. Id leo in vitae turpis massa sed elementum tempus egestas.\n\n- Est pellentesque elit ullamcorper dignissim cras tincidunt lobortis feugiat vivamus\n- Sed felis eget velit aliquet sagittis id consectetur. Interdum varius sit amet mattis\n- Orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor.\n\n Integer enim neque volutpat ac tincidunt vitae. Ac turpis egestas maecenas pharetra convallis posuere. Urna neque viverra justo nec ultrices dui.",
        "created_at": "created_at",
        "description": "description"
    }}'