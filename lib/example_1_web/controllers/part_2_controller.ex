defmodule Example1Web.Part2Controller do
  use Example1Web, :controller
  alias Example1.MockResource

  alias Example1.Part2.Producer
  alias Example1.Part2.MultiConsumerExample.Producer, as: MultiConsumerExampleProducer

  def single_consumer_genstage(conn, _params) do
    :ok = Producer.enqueue_event("some_data")
    text(conn, "OK")
  end

  def multi_consumer_genstage(conn, _params) do
    :ok = Producer.enqueue_event("some_data", producer: MultiConsumerExampleProducer)
    text(conn, "OK")
  end
end
