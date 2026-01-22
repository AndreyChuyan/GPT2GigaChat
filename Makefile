.PHONY: help up up-d down restart logs logs-follow logs-save rebuild status

# Цвета
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
CYAN := \033[0;36m
RESET := \033[0m

.DEFAULT_GOAL := help

help: ## 📌 Справка
	@echo " _     _ "
	@echo "  \___/  "
	@echo " ( ^_^ )   GPT2GigaChat"
	@echo " /| o |\   🐞 Dbgops"
	@echo " /|___|\   by Andrey Chuyan"
	@echo " _/  \_    https://chuyana.ru"
	@echo ""
	@echo "$(BLUE)🤖 GPT2GIGA - OpenAI совместимый прокси для GigaChat$(RESET)"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  $(CYAN)%-15s$(RESET) %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""

up: ## ▶ Запустить с логами
	@docker compose up

up-d: ## ▶ Запустить в фоне
	@docker compose up -d
	@echo "$(GREEN)✓ Сервис запущен$(RESET)"

down: ## ⏹ Остановить
	@docker compose down
	@echo "$(GREEN)✓ Сервис остановлен$(RESET)"

restart: ## 🔄 Перезагрузить
	@docker compose restart gpt2giga
	@echo "$(GREEN)✓ Перезагружено$(RESET)"

logs: ## 📋 Показать логи (100 строк)
	@docker compose logs --tail=100 gpt2giga

logs-follow: ## 👀 Следить за логами
	@docker compose logs -f gpt2giga

logs-save: ## 💾 Сохранить логи в gpt2giga.log
	@docker compose logs gpt2giga > gpt2giga.log
	@echo "$(GREEN)✓ Логи сохранены в gpt2giga.log$(RESET)"

rebuild: ## 🔨 Пересобрать образ
	@docker compose down
	@docker compose up -d --build
	@echo "$(GREEN)✓ Пересобрано и запущено$(RESET)"

status: ## 📊 Статус сервиса
	@docker compose ps gpt2giga
