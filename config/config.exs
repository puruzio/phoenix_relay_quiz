# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :app, App.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "x4KbWPtieC/U+FHsgnbFd+nmElLV8tpAg5615wnHD9MMSjKYS1mNDdETi3lksMUX",
  render_errors: [accepts: ["html"]],
  pubsub: [name: App.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :app, App.Repo,
  adapter: RethinkDB.Ecto

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Guardian setup
config :joken, config_module: Guardian.JWT

config :guardian, Guardian,
  #allowed_algos: ["HS512"], # optional
  #verify_module: Guardian.JWT,  # optional
  issuer: "App",
  ttl: { 3, :days },
  verify_issuer: true,
  secret_key: "+/HZDLRRXtmKO5oN1n/vw35suQI/2iLJNr6sKhs8iDod8H0wWRYwPe5FNYZpOvQj",
  serializer: App.GuardianSerializer


# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
