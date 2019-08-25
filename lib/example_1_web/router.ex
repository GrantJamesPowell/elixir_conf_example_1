defmodule Example1Web.Router do
  use Example1Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phoenix.LiveView.Flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Example1Web do
    pipe_through :browser

    get "/", PageController, :index
    live "/part1", Part1Live
  end

  scope "/part1", Example1Web do
    get "/async", Part1Controller, :async
    get "/serial", Part1Controller, :serial
  end

  scope "/part2", Example1Web do
    get "/single_consumer_genstage", Part2Controller, :single_consumer_genstage
    get "/multi_consumer_genstage", Part2Controller, :multi_consumer_genstage
  end
end
