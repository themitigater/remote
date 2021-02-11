defmodule Remote.Helpers do
  @moduledoc """
  Helper functions for use across the app.
  """

  @doc """
  Formats timestamp to ISO8601 format with seconds precision

  ## Examples

      iex> format_timestamp(nil)
      nil

      iex> format_timestamp(~U[])
      "2020-07-30 17:09:33Z"
  """
  def format_timestamp(nil), do: nil

  def format_timestamp(timestamp),
    do: DateTime.truncate(timestamp, :second) |> DateTime.to_string()
end
