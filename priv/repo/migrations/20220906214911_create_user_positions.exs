defmodule Nicefitserver.Repo.Migrations.CreateUserPositions do
  use Ecto.Migration

  def change do
    create table(:user_positions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)
      add :position_id, references(:positions, type: :uuid, on_delete: :nothing)
      add :date, :date
      add :cardinality, :string
      add :value, :integer
      timestamps()
    end
  end
end
