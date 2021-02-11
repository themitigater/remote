defmodule RemoteWeb.PointsView do
  use RemoteWeb, :view
  alias Remote.Helpers

  def render("query.json", %{data: %{users: users, timestamp: timestamp}}) do
    %{
      users: users,
      timestamp: Helpers.format_timestamp(timestamp)
    }
  end
end
