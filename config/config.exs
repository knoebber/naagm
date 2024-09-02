# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :naagm,
  ecto_repos: [Naagm.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :naagm, NaagmWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: NaagmWeb.ErrorHTML, json: NaagmWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Naagm.PubSub,
  live_view: [signing_salt: "45G5bNVR"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.19.8",
  default: [
    args:
      ~w(js/app.js --bundle --target=esnext --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

import_config "secrets.exs"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
