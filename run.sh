#!/bin/bash

build_generator() {
    echo "Сборка образа генератора..."
    docker build -f Dockerfile.generator -t generate-image .
    echo "Образ создан"
}

run_generator() {
    echo "Запуск генератора..."
    docker run --rm -v "$(pwd)/data:/data" generate-image
    echo "Cоздан файл data.csv в data/"
}

create_local_data() {
    echo "Локальная генерация..."
    python generate.py local_data
    echo "Файл data.csv создан"
}

case "$1" in
    build_generator)
        build_generator
        ;;
    run_generator)
        run_generator
        ;;
    create_local_data)
        create_local_data
        ;;
    *)
        echo "Запуск функции из run.sh..."
        exit 1
        ;;
esac