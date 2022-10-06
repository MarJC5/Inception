# COLORS
GREEN		= \033[1;32m
RED 		= \033[1;31m
ORANGE		= \033[1;33m
CYAN		= \033[1;36m
RESET		= \033[0m

# FOLDER
SRCS_DIR	= ./srcs/
NGINX_DIR	= ${SRCS_DIR}requirements/nginx/

# VARIABLES
ENV_FILE	= ${SRCS_DIR}.env
NAME		= $(shell grep APP_NAME ${ENV_FILE} | cut -d '=' -f2)
DOMAIN		= $(shell grep DOMAIN ${ENV_FILE} | cut -d '=' -f2)

# COMMANDS
DOCKER		=  docker compose -f ${SRCS_DIR}docker-compose.yml --env-file ${ENV_FILE}

# If no rule is matched, pass the argument to the shell
%:
	@:

all: up

##@ Setup
env: ## Create/Overwrite .env file
	@bash ./srcs/requirements/tools/env-gen.sh

##@ Docker
ps: ## List containers
	@echo "${CYAN}List containers${RESET}"
	@${DOCKER} ps

up: ## Start containers
	@echo "${GREEN}Building ${NAME}...${RESET}"
	@${DOCKER} up -d nginx
	@${DOCKER} up -d wordpress

stop: ## Stop containers
	@echo "${RED}Stopping ${NAME}...${RESET}"
	@${DOCKER} stop

down: ## Stop and remove containers
	@echo "${GREEN}Stopping ${NAME}...${RESET}"
	@${DOCKER} down

clean: ## Remove all containers
	@echo "${GREEN}Removing ${NAME}...${RESET}"
	@docker system prune -a -f

restart: ## Restart containers
	@echo "${GREEN}Restarting ${NAME}...${RESET}"
	@${DOCKER} restart

rebuild: ## Rebuild containers
	@echo "${GREEN}Rebuilding ${NAME}...${RESET}"
	@${DOCKER} up --build -d

##@ Help
info: ## Display containers running urls

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@
.PHONY: all env ps up down clean restart rebuild info help