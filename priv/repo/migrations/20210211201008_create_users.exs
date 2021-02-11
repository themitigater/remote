defmodule Remote.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :points, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
