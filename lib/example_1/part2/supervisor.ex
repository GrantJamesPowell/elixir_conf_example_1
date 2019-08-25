defmodule Example1.Part2.Supervisor do
  use Supervisor
  alias Example1.Part2.{Producer, Consumer}
  import Supervisor, only: [child_spec: 2]

  alias Example1.Part2.MultiConsumerExample.Producer, as: MCP
  alias Example1.Part2.MultiConsumerExample.Consumer1, as: C1
  alias Example1.Part2.MultiConsumerExample.Consumer2, as: C2
  alias Example1.Part2.MultiConsumerExample.Consumer3, as: C3

  def start_link([]), do: start_link(name: __MODULE__)
  def start_link(name: name), do: Supervisor.start_link(__MODULE__, %{name: name}, name: name)

  def init(_init_arg) do
    children = [
      # single producer single consumer
      Producer,
      {Consumer, subscribe_to: [Producer]},

      # single producer, multiple consumer,
      child_spec({Producer, name: MCP}, id: MCP),
      child_spec({Consumer, name: C1, subscribe_to: [MCP]}, id: C1),
      child_spec({Consumer, name: C2, subscribe_to: [MCP]}, id: C2),
      child_spec({Consumer, name: C3, subscribe_to: [MCP]}, id: C3)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
