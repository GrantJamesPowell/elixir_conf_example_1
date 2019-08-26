defmodule Example1Web.Part2Controller do
  use Example1Web, :controller
  alias Example1.MockResource

  alias Example1.Part2.Producer

  def genstage(conn, _params) do
    :ok =
      Producer.enqueue_event(%{
        on_enqueue: &on_event_enqueue/0,
        on_event_processed: &on_event_processed/0,
        event_occurred_at: DateTime.utc_now()
      })

    text(conn, "OK")
  end

  def on_event_enqueue, do: Counter.increment(EventsInSystem)
  def on_event_processed, do: Counter.decrement(EventsInSystem)
end
