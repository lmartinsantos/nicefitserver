defmodule Nicefitserver.Repo.Migrations.CreateAttributes do
  use Ecto.Migration

  def change do
    create table(:attributes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end
  end
end
