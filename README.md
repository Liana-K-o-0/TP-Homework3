# Автор

Калажокова Лиана ТАДБ251

# Инструкция к запуску после создания Codespaces:

*1. В терминале дать права на выполнение кода*
chmod +x run.sh

*2. Собрать образы для контейнеров и сгенерировать файлы data.csv и report.html*
./run.sh build_generator
./run.sh run_generator
./run.sh build_reporter
./run.sh run_reporter

*3. Запустить контейнер с веб сервером*
./run.sh report_server

*4. Открыть вкладку PORTS и скопировать ссылку. Вставить её в свой браузер, дописав в конце /report.html*
Пример итоговой ссылки: https://xxxx-8080.app.github.dev/report.html

`Другие полезные команды:`

./run.sh structure - Структура всех файлов
./run.sh clear_data - Удаление сгенерированных данных
./run.sh inside_generator - Выведение содержимого генератора
./run.sh inside_reporter - Выведение содержимого репортера