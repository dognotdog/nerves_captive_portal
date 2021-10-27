# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :nerves_captive_portal, NervesCaptivePortalWeb.Endpoint,
  url: [host: "captive.portal"],
  secret_key_base: "GJUnNqPI+rqm4dCO5LpKrFEnN882HBcvjcv/31q+bydZhZpeUDrjtxXuglSYmIlr",
  render_errors: [view: NervesCaptivePortalWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NervesCaptivePortal.PubSub,
  live_view: [signing_salt: "Z2gPf+wS"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :mime, :types, %{
  "application/captive+json" => ["captive-portal-json"]
}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
