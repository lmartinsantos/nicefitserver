defmodule Nicefitserver.Repo.Migrations.CreateProductTags do
  use Ecto.Migration

  def change do
    create table(:product_tags, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :value, :string
      add :cardinality, :string
      add :product_id, references(:products, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:product_tags, [:product_id])
  end
end
