# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :remote,
  ecto_repos: [Remote.Repo]

# Configures the endpoint
config :remote, RemoteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gCRmuGhuEO0K1lUqt6Ekdsmy2BMtUXI92YvCZTqUMDAhsPKYc/y8WNyUi7qHBo5k",
  render_errors: [view: RemoteWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Remote.PubSub,
  live_view: [signing_salt: "wigPkG//"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
