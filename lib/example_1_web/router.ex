defmodule Example1Web.Router do
  use Example1Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Example1Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/part1", Example1Web do
    get "/async", Part1Controller, :async
    get "/serial", Part1Controller, :serial
  end
end
