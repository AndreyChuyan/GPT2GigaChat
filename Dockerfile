# Используем официальный образ Python
FROM python:3.11-slim

# Установить переменные окружения
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# Установить рабочую директорию
WORKDIR /app

# Установить системные зависимости
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Установить gpt2giga и зависимости
RUN pip install --upgrade pip setuptools wheel && \
    pip install gpt2giga

# Открыть порт (будет переопределён переменной окружения GPT2GIGA_PORT)
EXPOSE 8000

# Здоровье проверка
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:${GPT2GIGA_PORT:-8000}/v1/models || exit 1

# Запустить приложение (конфигурация через переменные окружения)
CMD ["gpt2giga"]
