defmodule Nicefitserver.Repo do
  use Ecto.Repo,
    otp_app: :nicefitserver,
    adapter: Ecto.Adapters.MyXQL
end
