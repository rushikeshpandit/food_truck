defmodule FoodTruck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FoodTruckWeb.Telemetry,
      FoodTruck.Repo,
      {DNSCluster, query: Application.get_env(:food_truck, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FoodTruck.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FoodTruck.Finch},
      # Start a worker by calling: FoodTruck.Worker.start_link(arg)
      # {FoodTruck.Worker, arg},
      # Start to serve requests, typically the last entry
      FoodTruckWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FoodTruck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoodTruckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
