
APP_SERVICE=app
DC=docker-compose

include .env

env:
ifndef UID
	echo "" >> .env;
	echo "APP_USER=dev" >> .env;
	echo "UID=$(shell id -u)" >> .env;
	echo "GID=$(shell id -g)" >> .env;
endif

build: env
	$(DC) build

up: env
	$(DC) up -d

down:
	$(DC) down

bundle:
	$(DC) run --rm $(APP_SERVICE) bundle install

db-create:
	$(DC) run --rm $(APP_SERVICE) rails db:create

db-migrate:
	$(DC) run --rm $(APP_SERVICE) rails db:migrate

console:
	$(DC) run --rm $(APP_SERVICE) rails console

test:
	$(DC) run --rm $(APP_SERVICE) bundle exec rspec

sh:
	$(DC) run --rm $(APP_SERVICE) bash
