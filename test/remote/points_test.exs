defmodule Remote.PointsTest do
  use Remote.DataCase

  alias Remote.{Points, Users}
  alias Remote.Users.User

  describe "points genserver" do
    test "query/1 returns users and timestamp, validates timestamp is set post first query" do
      assert {:ok, %{users: _, timestamp: nil}} = Points.query()

      assert {:ok, %{users: _, timestamp: timestamp}} = Points.query()

      refute timestamp == nil
    end

    test "validates user points are updated every minute" do
      %User{updated_at: prev_updated_at} = Users.list_user() |> List.last()

      :timer.sleep(60_000)

      %User{updated_at: updated_at} = Users.get_user!(1)
      assert DateTime.compare(updated_at, prev_updated_at) == :gt
    end
  end
end
