defmodule Remote.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Remote.Repo

  alias Remote.Users.User

  @doc """
  Returns the list of user.

  ## Examples

      iex> list_user()
      [%User{}, ...]

  """
  def list_user do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  Generates and Sets Random Points for the given user.

  ## Examples

      iex> set_random_points(%User{})
      {:ok, %User{}}

      iex> set_random_points(%User{})
      {:error, %Ecto.Changeset{}}
  """
  @spec set_random_points(User.t()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def set_random_points(%User{} = user) do
    attrs = %{points: generate_number()}

    update_user(user, attrs)
  end

  @doc """
  Generates a random number in the range of (0, 100)

  ## Examples

      iex> generate_number
      10
  """
  @spec generate_number() :: Integer.t()
  def generate_number do
    Enum.random(0..100)
  end

  @doc """
  Queries the Database to fetch two users with points > min_points

  ## Examples

    iex> first_two_users(3)
    [{id: 1, points: 30}, {id: 72, points: 30}]
  """
  @type users :: [
          %{
            required(:id) => Integer.t(),
            required(:points) => Integer.t()
          }
        ]
  @spec first_two_users(Integer.t()) :: users :: List.t()
  def first_two_users(min_points) when is_integer(min_points) do
    from(u in User, where: u.points > ^min_points, select: %{id: u.id, points: u.points}, limit: 2)
    |> Repo.all()
  end
end
