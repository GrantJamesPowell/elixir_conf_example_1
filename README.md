# Building Scalable Real-time Systems in Elixir - Section 1 Example

# Getting Setup
  * Install dependencies with `mix deps.get`
  * Install Node.js dependencies with `npm --prefix assets install`
  * Start Phoenix endpoint with `iex -S mix phx.server`
  * Now you can visit localhost:4000 from your browser.

## Section 1 Part 1

We want you to see the effects of serialism and parallelism in Elixir. We have coded a small app which will process
some work and respond to a request. In one case, the work will be done serially and in the same process as the request.
In another case, the work will be done asynchronously and the request will not wait for the work to be performed.

## 1. Understanding IO wait, What is `MockResource` Doing in Each Endpoint

Open the `MockResource` module found [here](/lib/example1/mock_resource)
  * What is the `use_resource` function doing?
  * What is the `current_requests` function doing?
  * Please adjust the `MockResource` to take 5x longer than it does right now
  * Where is an instance of `MockResource` being started in the supervision tree? Can you find it using the `:observer`
  * What are some examples of compute resources that `MockResource` models well? What are some compute resources that `MockResource` does not model well?

How is the `MockResource` being used in the `/part1/serial` endpoint? How is it being used in the `/part1/async` endpoint?

Find the LiveView [code](/lib/example_1_web/controllers/live/part_1_live.ex) for the `/part1` page
  * What is it measuring?

## 2. Using `ab` (A.K.A ApacheBench)

Apache Bench is a tool from the Apache foundation to load test HTTP servers. [docs](https://httpd.apache.org/docs/2.4/programs/ab.html)

After you've understood the runtime characteristics of the `part1/sync` and `part2/async` endpoints, guess at the results of the following benchmarks and then test your assumptions
  * 3000 requests using a concurrency of 50 against `part1/serial`
  * 3000 requests using a concurrency of 50 against `part1/async`

How long did each request take? Which endpoint returned to the client the fastest? What is the implication on memory and cpu usage, can you see these in the `:observer` screens?

```
ab -n 3000 -c 50 http://127.0.0.1:4000/part1/serial
```

```
ab -n 3000 -c 50 http://127.0.0.1:4000/part1/async
```

## 3.) Looking at concurrent requests to `MockResource` during your benchmarks

The number of concurrent requests can be found at `http://localhost:4000/part1`

Make a hypothesis about the number of concurrent requests to mock resources for each of the following benchmarks, then test your hypothesis
  * 3000 requests using a concurrency of 50 against `part1/serial`
  * 3000 requests using a concurrency of 50 against `part1/async`

What are the implications of the data you collected in these tests?
  * From the web client's perspective, which endpoint is faster?
  * What would happen is MockResource was your database? What if `MockResource` was a resource that could only handle limited load?

## 4.) (Hard Mode) How slow can you go

Make the requests to the endpoints fail and return a 500 if there are already 15 concurrent requests to the `MockResource`

## Section 1 Part 2

In this section we will be exploring building a data pipeline using GenStage

### 1.) Find the Genstage Components

Follow the supervision tree from your main [application supervisor](/lib/example_1/application.ex) `applciation.ex`, and locate the genstage components running in your process tree. Once you've found the code for the component, locate the processes running in the `:observer`

### 2.) Examine the GenStage

Starting with the part2 [controller](/lib/example_1_web/controllers/part_2_controller.ex), trace your way through the gen stage pipeline.
  * What is the controller doing?
  * What is the producer doing?
  * What is the consumer doing?

Take a look at the code for the control panel for part 2 `/lib/example_1_web/controllers/live/part_2_live.ex`
  * What is it doing?
  * What metrics is it collecting?

### 3.) Enqueue some events

Navigate to the `localhost:4000/part2`.

Predict the answers to the following questions, then verify your assumptions using the apache bench tool with 1000 requests to the `/part2/genstage` endpoint
  * How will the number of unprocessed events in the system change over time?
  * How will the `MockResource` usage change with the number of events?

```
ab -n 1000 -c 50 http://127.0.0.1:4000/part2/genstage
```

### 4.) Increase the number of consumers to 3

How will adding 2 more consumers to the system change the following values?
  * How will the speed of processing events change?
  * How will the `MockResource` usage change?

Add 2 more consumers to the system and then Verify your assumptions using `ab` and the dashboard at `localhost:4000/part2`

### 5.) Measure the latency of events flowing through your pipeline

Use the event the consumer is emitting in order to measure the latency of the events in the system

Answer the following questions
  * How does the latency each event experience change as the depth of the queue changes?
  * How does adding multiple consumers affect the average latency? (Its trickier than you'd think)

### 6.) (Hard Mode) Consumer Supervisor

Read the [docs](https://hexdocs.pm/gen_stage/ConsumerSupervisor.html) for consumer supervisor

Implement the genstage consumers as a consumer supervisor with a concurrency that can be controlled via the `config/config.exs`
