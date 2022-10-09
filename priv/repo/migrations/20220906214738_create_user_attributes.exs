defmodule Nicefitserver.Repo.Migrations.CreateUserAttributes do
  use Ecto.Migration

  def change do
    create table(:user_attributes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)
      add :attribute_id, references(:attributes, type: :uuid, on_delete: :nothing)
      add :date, :date
      add :cardinality, :string
      add :value, :string
      add :optional, :boolean, default: false, null: false
      timestamps()
    end
  end
end
