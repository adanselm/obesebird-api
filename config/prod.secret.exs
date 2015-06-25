use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :obesebird_api, ObesebirdApi.Endpoint,
  secret_key_base: System.get_env("SECRET_KEY_BASE")

# Configure your database
config :obesebird_api, ObesebirdApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: {:system, "DATABASE_URL"},
  size: 20 # The amount of database connections in the pool

config :ex_twitter, :oauth, [
   consumer_key: System.get_env("CONSUMER_KEY"),
   consumer_secret: System.get_env("CONSUMER_SECRET"),
   access_token: System.get_env("ACCESS_TOKEN"),
   access_token_secret: System.get_env("ACCESS_SECRET")
]
