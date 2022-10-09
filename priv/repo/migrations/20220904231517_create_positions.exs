defmodule Nicefitserver.Repo.Migrations.CreatePositions do
  use Ecto.Migration

  def change do
    create table(:positions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :dimensions, :integer

      timestamps()
    end
  end
end
