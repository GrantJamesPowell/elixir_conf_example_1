defmodule Example1.Application do
  use Application
  alias Example1.MockResource

  def start(_type, _args) do
    resource_specs =
      [Part1, Part2.A, Part2.B, Part2.C]
      |> Enum.map(&Supervisor.child_spec({MockResource, name: &1}, id: &1))

    children =
      [
        Example1Web.Endpoint
      ] ++ resource_specs

    opts = [strategy: :one_for_one, name: Example1.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Example1Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
