defmodule PotionTalk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PotionTalkWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:potion_talk, :dns_cluster_query) || :ignore},
      # Start the ETS table as a worker
      PotionTalk.Storage.ChatStorage,
      {Phoenix.PubSub, name: PotionTalk.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PotionTalk.Finch},
      # Start a worker by calling: PotionTalk.Worker.start_link(arg)
      # {PotionTalk.Worker, arg},
      # Start to serve requests, typically the last entry
      PotionTalkWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PotionTalk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PotionTalkWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
