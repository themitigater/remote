defmodule RemoteWeb.Router do
  use RemoteWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope log: false do
    pipe_through :api
    get "/", RemoteWeb.PointsController, :query
  end
end
