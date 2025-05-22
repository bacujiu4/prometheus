#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "ОШИБКА: Требуются права root!"
    echo "Пожалуйста, запустите скрипт с помощью sudo: sudo $0"
    exit 1
fi

echo "Обновление пакетов..."
if ! apt-get update -qq; then
    echo "Ошибка при обновлении списка пакетов"
    exit 1
fi

# Установка зависимостей
DEPS=(
        prometheus
        prometheus-alertmanager
        prometheus-node-exporter
	iptables
	iptables-persistent
        dh-make
        devscripts
        build-essential
)

echo "Установка пакетов: ${DEPS[*]}"
if ! apt-get install -y "${DEPS[@]}"; then
    echo "Ошибка при установке пакетов"
    exit 1
fi

echo "Все зависимости установлены успешно"
