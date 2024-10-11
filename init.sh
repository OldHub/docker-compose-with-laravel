#!/bin/bash

EXAMPLE_FILE="./docker/docker-compose.example"
OUTPUT_FILE="./docker/docker-compose.yml"

read -p "Enter container name: " CONTAINER_NAME

if [ -n "$CONTAINER_NAME" ]; then
    sed "s/your-project/$CONTAINER_NAME/g" "$EXAMPLE_FILE" > "$OUTPUT_FILE"
else
    cp "$EXAMPLE_FILE" "$OUTPUT_FILE"
fi

read -p "Want to install Redis? (y/n): " INSTALL_REDIS
INSTALL_REDIS=${INSTALL_REDIS,,}

read -p "Want to install MailHog? (y/n): " INSTALL_MAILHOG
INSTALL_MAILHOG=${INSTALL_MAILHOG,,}

read -p "Want to install laravel? (y/n): " INSTALL_LARAVEL
INSTALL_LARAVEL=${INSTALL_LARAVEL,,}

if [ "$INSTALL_REDIS" != "n" ]; then
    sed -i '/redis:/,/^[^ ]/d' "$OUTPUT_FILE"
fi

if [ "$INSTALL_MAILHOG" != "n" ]; then
    sed -i '/mailhog:/,/^[^ ]/d' "$OUTPUT_FILE"
fi

if [ "$INSTALL_LARAVEL" != "y"] && [ ! -d "src" ]; then
    sudo mkdir src
    sudo chmod 777 -R src
    git clone --depth 1 git@github.com:laravel/laravel.git src
fi
