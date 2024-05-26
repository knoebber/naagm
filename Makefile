ifeq "$(MIX_ENV)" "prod"
    DEPS_FLAGS:= --only prod
    NPM_FLAGS:= --omit=dev
endif

all: deps create_db js compile assets migrate

warnings:
	mix compile --all-warnings

format:
	mix format mix.exs "lib/**/*.{ex,exs}" "test/**/*.{ex,exs}"

server:
	mix phx.server

test:
	mix test

reset_test:
	MIX_ENV=test mix ecto.reset

hex:
	mix local.hex --force

rebar:
	mix local.rebar --force

deps: hex rebar
	mix deps.get $(DEPS_FLAGS)

create_db:
	mix ecto.create

js:
	cd assets/; npm i $(NPM_FLAGS)

compile:
	mix compile

assets:
	mix assets.deploy

migrate:
	mix ecto.migrate

deploy: test
	echo "for DEVIN to do 😸"

.PHONY: all format test hex rebar deps create_db js compile assets migrate deploy warnings
