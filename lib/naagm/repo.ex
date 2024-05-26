defmodule Naagm.Repo do
  use Ecto.Repo,
    otp_app: :naagm,
    adapter: Ecto.Adapters.SQLite3
end
