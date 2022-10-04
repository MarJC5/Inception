.DEFAULT_GOAL := help

# COLORS
GREEN		= \033[1;32m
RED 		= \033[1;31m
ORANGE		= \033[1;33m
CYAN		= \033[1;36m
RESET		= \033[0m

# FOLDER
SRCS		= ./srcs/
NGINX_DIR	= ${SRCS}requirements/nginx/
WP_DIR		= ${SRCS}requirements/wordpress/
SQL_DIR		= ${SRCS}requirements/mariadb/
ADMINER_DIR	= ${SRCS}requirements/adminer/
PHP_DIR		= ${SRCS}requirements/php/

# VARIABLES
ENV_FILE	= ${SRCS}env.example
NAME		= $(shell grep APP_NAME ${ENV_FILE} | cut -d '=' -f2)
DOMAINE		= $(shell grep DOMAINE ${ENV_FILE} | cut -d '=' -f2)


##@ 
%:
	@:

info: ## Display containers running urls

help:
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: help