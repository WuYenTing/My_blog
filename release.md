1. mix phx.gen.secret -> REALLY_LONG_SECRET
2. export SECRET_KEY_BASE=REALLY_LONG_SECRET
3. export DATABASE_URL=ecto://{DB_USER}:{DB_PASSWORD}@{DB_HOSTNAME}/{DB_DATABASENAME}
# SECRET_KEY_BASE
# The secret key base is used to sign/encrypt cookies and other secrets.
# A default value is used in config/dev.exs and config/test.exs but you
# want to use a different value for prod and you most likely don't want
# to check this value into version control, so we use an environment
# variable instead.

4. mix deps.get --only prod
5. MIX_ENV=prod mix compile
# Getting all dependencies and compiling.

6. mix phx.gen.release