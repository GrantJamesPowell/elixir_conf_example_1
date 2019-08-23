defmodule Example1.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Example1Web.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Example1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Example1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
