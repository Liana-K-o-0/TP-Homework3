#!/bin/bash

build_generator() {
    echo "Сборка образа генератора..."
    docker build -f Dockerfile.generator -t generate-image .
    echo "Образ создан"
}

run_generator() {
    echo "Запуск генератора..."
    docker run --rm -v "$(pwd)/data:/data" generate-image
    echo "Создан файл data.csv в data/"
}

create_local_data() {
    echo "Локальная генерация..."
    python generate.py local_data
    echo "Файл data.csv создан"
}


build_reporter() {
    echo "Сборка образа для контейнера аналитика..."
    docker build -f Dockerfile.reporter -t reporter-image .
    echo "Образ создан"
}

run_reporter() {
    echo "Запуск контейнера для генерации отчета..."
    docker run --rm -v "$(pwd)/data:/data" reporter-image
    echo "Отчет создан"
}


structure() {
    echo "Структура всех файлов:"
    ls -R1
}

clear_data() {
    echo "Удаление сгенерированных данных..."
    rm -f data/*.csv data/*.html
    echo "Сгенерированные данные удалены"
}

inside_generator() {
    echo "Запуск контейнера генератора..."
    echo "Выведение содержимого генератора..."
    docker run --rm -v "$(pwd)/data:/data" generate-image ls -la /data/
}

inside_reporter() {
    echo "Запуск контейнера аналитика..."
    echo "Выведение содержимого репортера..."
    docker run --rm -v "$(pwd)/data:/data" reporter-image ls -la /data/
}

report_server() {
    echo "запуск контейнера с веб-сервером"

    docker stop report-server 2>/dev/null
    docker rm report-server 2>/dev/null
    docker run --rm -d -p 8080:80 -v "$(pwd)/data:/usr/share/nginx/html:ro" --name report-server nginx:alpine
    echo "Сервер запущен"
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
    build_reporter)
        build_reporter
        ;;
    run_reporter)
        run_reporter
        ;;
    structure)
        structure
        ;;
    clear_data)
        clear_data
        ;;
    inside_generator)
        inside_generator
        ;;
    inside_reporter)
        inside_reporter
        ;;
    report_server)
        report_server
        ;;
    *)
        echo "Доступные команды:"
        echo "  build_generator, run_generator, create_local_data"
        echo "  build_reporter, run_reporter, structure"
        echo "  clear_data, inside_generator, inside_reporter"
        exit 1
        ;;
esac