defmodule Remote.Points do
  @moduledoc """
  GenServer implementation which
    1. Generates a max_number every minute and stores in Process memory.
    2. Randomly sets points(0-100) for every user in DB every 1 minute.
    3. Exposes a public API to return the first 2 users with Points > max_number
    and stores the queried time in Process Memory.

    Process State: {
       Integer.t(),
       nil | DateTime.t()
    }

  """
  require Logger

  use GenServer

  alias Remote.Users

  def start_link(_) do
    result = GenServer.start_link(__MODULE__, nil, name: __MODULE__)

    Logger.info("Started Points GenServer")

    result
  end

  @doc """
  Returns the first two users with points > max_number and the
  timestamp of the previous query.

  ## Examples

      iex> query()
        {:ok, %{
          users: [%{id: 1, points: 2}, %{id: 2, points: 10}],
          timestamp:
        }}

      iex> query()
        {:ok, %{
          users: [%{id: 1, points: 100}],
          timestamp:
        }}
  """
  def query, do: GenServer.call(__MODULE__, :query)

  @impl true
  def init(_) do
    schedule_work()

    default_state = {Users.generate_number(), nil}
    {:ok, default_state}
  end

  defp frequency do
    if Mix.env() == :test do
      1_000
    else
      60_000
    end
  end

  defp schedule_work,
    do:
      Process.send_after(
        self(),
        :work,
        frequency()
      )

  @impl true
  @doc """

  """
  def handle_info(:work, {_, timestamp}) do
    # Can also use Task.async_stream() to parallelize updates across
    Users.list_user()
    |> Enum.each(fn user ->
      user |> Users.set_random_points()
    end)

    updated_state = {Users.generate_number(),  timestamp}

    # This ensures that there are never two parallel updates triggered
    schedule_work()
    {:noreply, updated_state}
  end

  @impl true
  def handle_call(:query, _from, {max_number, timestamp}) do
    users = Users.first_two_users(max_number)

    data = %{users: users, timestamp: timestamp}

    updated_state = {max_number, DateTime.utc_now()}

    {:reply, {:ok, data}, updated_state}
  end
end
