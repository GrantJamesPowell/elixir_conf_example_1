defmodule Example1.Part2.Producer do
  use GenStage

  def start_link([]), do: start_link(name: __MODULE__)
  def start_link(name: name), do: GenStage.start_link(__MODULE__, %{}, name: name)

  def init(%{}), do: {:producer, :unused_init_state}

  def handle_demand(demand, state), do: {:noreply, [], state}
end
