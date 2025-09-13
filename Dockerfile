# Используем официальный Node.js образ с Alpine Linux для минимального размера
FROM node:18-alpine

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем файлы зависимостей
COPY --chown=1001:0 package*.json ./

# Создаем пользователя
RUN adduser -D -u 1001 appuser

# Устанавливаем все зависимости включая devDependencies
RUN npm ci --include=dev

# Даем права пользователю на /app
USER root
RUN chown -R 1001:0 /app
USER 1001

# Копируем исходный код
COPY --chown=1001:0 . .

# Открываем порт 3000
EXPOSE 3000

# Команда для запуска в dev режиме
CMD ["npx", "craco", "start"]