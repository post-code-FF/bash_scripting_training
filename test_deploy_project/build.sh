#!/bin/bash

set -e

function cleanup() {
    echo "Очистка временных файлов"
    rm -rf "test.txt"
}

trap cleanup EXIT 

echo "Создаем временные файлы"
touch "test.txt"

echo "Какая-то опасная команда"
false
