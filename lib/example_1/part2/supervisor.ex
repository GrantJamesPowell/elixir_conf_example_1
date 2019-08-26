defmodule Example1.Part2.Supervisor do
  use Supervisor
  import Supervisor, only: [child_spec: 2]

  alias Example1.MockResource
  alias Example1.Part2.{Producer, Consumer}

  def start_link([]), do: start_link(name: __MODULE__)
  def start_link(name: name), do: Supervisor.start_link(__MODULE__, %{name: name}, name: name)

  def init(_init_arg) do
    children = [
      Producer,
      {MockResource, name: Part2},
      {Counter, name: EventsInSystem},
      child_spec({Consumer, name: C1, subscribe_to: [Producer], resource: Part2}, id: C1),
      child_spec({Consumer, name: C2, subscribe_to: [Producer], resource: Part2}, id: C2),
      child_spec({Consumer, name: C3, subscribe_to: [Producer], resource: Part2}, id: C3)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
