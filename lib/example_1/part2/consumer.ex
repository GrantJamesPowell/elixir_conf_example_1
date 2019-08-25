defmodule Example1.Part2.Consumer do
  use GenStage

  def start_link([]), do: start_link(name: __MODULE__)
  def start_link(name: name), do: GenStage.start_link(__MODULE__, %{}, name: name)

  def init(%{}), do: {:consumer, :the_state_does_not_matter}

  def handle_events(events, _from, state) do
    IO.inspect(events)
    {:noreply, [], state}
  end
end
