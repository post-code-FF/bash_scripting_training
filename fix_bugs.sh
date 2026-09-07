
#!/bin/bash
# Скрипт обновления конфигурации burmalda-service

set -e
set -o pipefail

trap 'rm -f /tmp/temp_config.json' EXIT

# Скачиваем новый конфиг во временную папку
cd /opt/burmalda/config
# cat config_backup.json | grep -v 'debug' > /tmp/temp_config.json
grep -v 'debug' < config_backup.json > /tmp/temp_config.json
curl -sf http://internal.server/new_config.json >> /tmp/temp_config.json

# Проверяем синтаксис (допустим, утилита config-validator возвращает код 1 при ошибке)
config-validator /tmp/temp_config.json

# Если всё ок, заменяем рабочий конфиг и перезапускаем
mv /tmp/temp_config.json /opt/burmalda/config/config.json
systemctl restart burmalda-service
echo "Update Success!"