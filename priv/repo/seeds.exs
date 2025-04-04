# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Remote.Repo.insert!(%Remote.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Logger

alias Remote.{Users}

Range.new(1, 100)
|> Enum.to_list()
|> Enum.each(fn _ ->
  Users.create_user(%{points: 0})
end)

Logger.info("Seeds Setup")
