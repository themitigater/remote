defmodule Remote.UsersTest do
  use Remote.DataCase

  alias Remote.Users

  describe "users" do
    alias Remote.Users.User

    @valid_attrs %{points: 42}
    @update_attrs %{points: 43}
    @invalid_attrs %{points: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.points == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.points == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end

  describe "points" do
    test "set_random_points/1 return {:ok, %User{}}" do
      user = user_fixture()

      assert {:ok, user} = user |> Users.set_random_points()
      assert user.points >= 0
      assert user.points <= 100
    end

    test "first_two_users/1 returns a list of 2 users" do
      _user_1 = user_fixture(%{points: 100})
      _user_2 = user_fixture(%{points: 50})
      _user_3 = user_fixture(%{points: 30})

      assert [%{id: _, points: _}, %{id: _, points: _}] = Users.first_two_users(0)
    end

    test "first_two_users/1 returns a list of 0 users" do
      _user_1 = user_fixture(%{points: 99})
      _user_2 = user_fixture(%{points: 50})
      _user_3 = user_fixture(%{points: 30})

      assert [] == Users.first_two_users(100)
    end
  end
end
