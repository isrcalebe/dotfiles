ohai_section_begin "database"

# Install default databases
if [[ -v DEVKIT_FIRST_RUN_DBS ]]; then
  dbs=$DEVKIT_FIRST_RUN_DBS
else
  AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
  dbs=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --height 5 --header "Select databases (runs in Docker)")
fi

if [[ -n "$dbs" ]]; then
  for db in $dbs; do
    case $db in
    MySQL)
      ohai "Installing MySQL (runs in Docker)"
      sudo docker ps -a --format '{{.Names}}' | grep -w mysql8 >/dev/null || sudo docker run -d --restart unless-stopped -p "127.0.0.1:3306:3306" --name=mysql8 -e MYSQL_ROOT_PASSWORD= -e MYSQL_ALLOW_EMPTY_PASSWORD=true mysql:8.4
      ;;
    Redis)
      ohai "Installing Redis (runs in Docker)"
      sudo docker ps -a --format '{{.Names}}' | grep -w redis >/dev/null || sudo docker run -d --restart unless-stopped -p "127.0.0.1:6379:6379" --name=redis redis:7
      ;;
    PostgreSQL)
      ohai "Installing PostgreSQL (runs in Docker)"
      sudo docker ps -a --format '{{.Names}}' | grep -w postgres16 >/dev/null || sudo docker run -d --restart unless-stopped -p "127.0.0.1:5432:5432" --name=postgres16 -e POSTGRES_HOST_AUTH_METHOD=trust postgres:16
      ;;
    esac
  done
fi

ohai_section_end "database"
