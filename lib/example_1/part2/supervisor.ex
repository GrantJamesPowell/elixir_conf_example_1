defmodule Example1.Part2.Supervisor do
  use Supervisor
  alias Example1.Part2.Producer

  def start_link([]), do: start_link(name: __MODULE__)
  def start_link(name: name), do: Supervisor.start_link(__MODULE__, %{name: name}, name: name)

  def init(_init_arg) do
    children = [
      Producer
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
