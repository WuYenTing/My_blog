1. brew install postgresql@17
2. echo 'export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"' >> .zshrc
3. brew services start postgresql@17
4. check postgresql@17 status
    a. brew services list -> postgresql@17 started
    b. lsof -i :5432 -> postgres is listing
    c. ps aux | grep postgres -> check /opt/homebrew/opt/postgresql@17/bin/postgres -D /opt/homebrew/var/postgresql@17
