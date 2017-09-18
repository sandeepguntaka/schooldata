# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :schooldata,
  ecto_repos: [Schooldata.Repo]

# Configures the endpoint
config :schooldata, Schooldata.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i4F8EUB/AoyQQlX01DJpfppENSeXBeXjJ8QxypZU2Tr7ZATVrZgxlBLhbR9wmcBp",
  render_errors: [view: Schooldata.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Schooldata.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :guardian, Guardian,
issuer: "Schooldata.#{Mix.env}",
ttl: {30, :days},
verify_issuer: true,
serializer: Schooldata.GuardianSerializer,
secret_key: to_string(Mix.env) <> "SuPerseCret_aBraCadabrA"