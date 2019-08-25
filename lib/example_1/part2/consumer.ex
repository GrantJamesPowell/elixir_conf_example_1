defmodule Example1.Part2.Consumer do
  use GenStage
  require Logger
  alias Example1.MockResource

  def start_link(opts) do
    name = opts[:name] || __MODULE__
    subscribe_to = opts[:subscribe_to]
    resource = opts[:resource]
    GenStage.start_link(__MODULE__, %{subscribe_to: subscribe_to, resource: resource}, name: name)
  end

  def init(%{subscribe_to: subs, resource: resource}),
    do: {:consumer, %{resource: resource}, subscribe_to: subs}

  def handle_events(events, _from, %{resource: resource} = state) do
    me = Process.info(self())[:registered_name]

    Logger.info("Process: #{me} is handling #{length(events)} events")

    for _event <- events do
      :ok = MockResource.use_resource(resource)
    end

    {:noreply, [], state}
  end
end
