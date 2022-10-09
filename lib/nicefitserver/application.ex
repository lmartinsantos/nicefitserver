defmodule Nicefitserver.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Nicefitserver.Repo,
      NicefitserverWeb.Telemetry,
      {Phoenix.PubSub, name: Nicefitserver.PubSub},
      NicefitserverWeb.Endpoint,
      # Start a worker by calling: Nicefitserver.Worker.start_link(arg)
      # {Nicefitserver.Worker, arg}
      Nicefitserver.Estimator.Supervisor
    ]

    opts = [strategy: :one_for_one, name: Nicefitserver.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    NicefitserverWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
