# curl 'https://ja.wordpress.org/wordpress-5.2.13-ja.tar.gz' -o './src/html/wp5_2_13jp.tar.gz' \
# && tar -xvzf ./src/html/wp5_2_13jp.tar.gz ./src/html \
devcontainer open

# docker compose -f ./.devcontainer/docker-compose.cent_apache_wp.yml build --no-cache
# docker compose -f ./.devcontainer/docker-compose.cent_apache_wp.yml up --force-recreate
