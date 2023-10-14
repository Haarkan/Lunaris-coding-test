defmodule LunarisApi.Repo do
  use Ecto.Repo,
    otp_app: :lunaris_api,
    adapter: Ecto.Adapters.Postgres
end
