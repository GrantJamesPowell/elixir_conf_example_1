defmodule Example1.Application do
  use Application
  alias Example1.MockResource

  def start(_type, _args) do
    children =
      [
        Example1Web.Endpoint,
        {MockResource, name: Part1}
      ]

    opts = [strategy: :one_for_one, name: Example1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Example1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end

