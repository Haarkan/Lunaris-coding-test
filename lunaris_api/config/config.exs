# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lunaris_api,
  ecto_repos: [LunarisApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :lunaris_api, LunarisApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6d5rkizEFFgfDcsobnVry4iS3hUB99CSTTGCt1pELKqk0tXgXk+ie8q3Jx7beGCr",
  render_errors: [view: LunarisApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: LunarisApi.PubSub,
  live_view: [signing_salt: "ihQVN0Rn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
