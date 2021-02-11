defmodule RemoteWeb.PointsControllerTest do
  use RemoteWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "query points" do
    test "renders first two users and the timestamp of last query", %{conn: conn} do
      conn = get(conn, Routes.points_path(conn, :query))

      assert %{
               "users" => _,
               "timestamp" => _
             } = json_response(conn, 200)
    end
  end
end
