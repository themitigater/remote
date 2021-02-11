defmodule RemoteWeb.PointsController do
  use RemoteWeb, :controller

  action_fallback RemoteWeb.FallbackController

  alias Remote.Points

  def query(conn, _params) do
    {:ok, data} = Points.query()

    render(conn, data: data)
  end
end
