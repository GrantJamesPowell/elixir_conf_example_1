defmodule Example1.Part2.Consumer do
  use GenStage

  def start_link(opts) do
    name = opts[:name] || __MODULE__
    subscribe_to = opts[:subscribe_to]
    GenStage.start_link(__MODULE__, %{subscribe_to: subscribe_to}, name: name)
  end

  def init(%{subscribe_to: subs}), do: {:consumer, :the_state_does_not_matter, subscribe_to: subs}

  def handle_events(events, _from, state) do
    me = Process.info(self())[:registered_name]

    for event <- events do
      IO.inspect("Process: #{me} is handling event #{event}")
    end

    {:noreply, [], state}
  end
end
