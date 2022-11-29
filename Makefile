# COLORS
GREEN		= \033[1;32m
RED 		= \033[1;31m
ORANGE		= \033[1;33m
CYAN		= \033[1;36m
RESET		= \033[0m

# FOLDER
SRCS_DIR	= ./srcs/
DOCKER_DIR	= ${SRCS_DIR}docker-compose.yml

# VARIABLES
ENV_FILE	= ${SRCS_DIR}.env
NAME		= $(shell grep -m 1 APP_NAME ${ENV_FILE} | cut -d '=' -f2)
DOMAIN		= $(shell grep -m 1 DOMAIN ${ENV_FILE} | cut -d '=' -f2)

# COMMANDS
DOCKER		=  docker compose -f ${DOCKER_DIR} --env-file ${ENV_FILE} -p ${NAME}

# If no rule is matched, pass the argument to the shell
%:
	@:

all: up

##@ Setup
env: ## Create/Overwrite .env file
	@bash ./srcs/requirements/tools/env-gen.sh

host: ## Add domain to /etc/hosts
	@bash ./srcs/requirements/tools/add-host.sh

##@ Docker
ps: ## List containers
	@echo "${CYAN}List containers${RESET}"
	@${DOCKER} ps

network: ## List networks
	@echo "${CYAN}List networks${RESET}"
	@docker network ls

pause: ## Pause containers
	@echo "${ORANGE}Pausing ${NAME}...${RESET}"
	@${DOCKER} pause

unpause: ## Unpause containers
	@echo "${ORANGE}Unpausing ${NAME}...${RESET}"
	@${DOCKER} unpause

start: ## Start containers
	@echo "${GREEN}Starting ${NAME}...${RESET}"
	@${DOCKER} start

stop: ## Stop containers
	@echo "${RED}Stopping ${NAME}...${RESET}"
	@${DOCKER} stop

up: ## Start containers
	@echo "${GREEN}Starting ${NAME}...${RESET}"
	@${DOCKER} up -d

build: ## Build or rebuild services
	@echo "${CYAN}Build or rebuild services${RESET}"
	@${DOCKER} build

down: ## Stop and remove containers
	@echo "${GREEN}Stopping ${NAME}...${RESET}"
	@${DOCKER} down -v --remove-orphans --rmi all

clean: ## Remove all containers
	@echo "${GREEN}Removing ${NAME}...${RESET}"
	@${DOCKER} rm -f
	@sudo rm -rf ~/data

restart: ## Restart containers
	@echo "${GREEN}Restarting ${NAME}...${RESET}"
	@${DOCKER} restart

rebuild: ## Rebuild containers
	@echo "${GREEN}Rebuilding ${NAME}...${RESET}"
	@${DOCKER} up --build -d

fclean: clean ## Remove all containers
	@echo "${GREEN}Removing ${NAME}...${RESET}"
	@${DOCKER} down -v --remove-orphans --rmi all

prune: ## Prune all
	@docker system prune -af

##@ Services
nginx: ## Start nginx container
	@echo "${GREEN}Building ${NAME}...${RESET}"
	@${DOCKER} up -d nginx

mariadb: ## Start mariadb container
	@echo "${GREEN}Building ${NAME}...${RESET}"
	@${DOCKER} up -d mariadb

wordpress: ## Start wordpress container
	@echo "${GREEN}Building ${NAME}...${RESET}"
	@${DOCKER} up -d wordpress

##@ Services bash
exec-wp: ## Execute wordpress container
	@echo "${GREEN}Executing ${NAME}...${RESET}"
	@${DOCKER} exec wordpress sh

exec-db: ## Execute mariadb container
	@echo "${GREEN}Executing ${NAME}...${RESET}"
	@${DOCKER} exec mariadb sh

exec-srv: ## Execute nginx container
	@echo "${GREEN}Executing ${NAME}...${RESET}"
	@${DOCKER} exec nginx sh

##@ Help
info: ## Display containers running urls
	@echo "${GREEN}Containers running urls${RESET}"
	@echo "Website: https://${DOMAIN}"
	@echo "Admin panel: https://${DOMAIN}/wp-admin"
	@echo "Adminer: http://localhost:8080"

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@
.PHONY: all env host ps pause unpause start stop up build down clean restart rebuild fclean nginx mariadb wordpress exec-wp exec-db exec-srv info help