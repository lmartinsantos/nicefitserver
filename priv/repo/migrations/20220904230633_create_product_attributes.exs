defmodule Nicefitserver.Repo.Migrations.CreateProductAttributes do
  use Ecto.Migration

  def change do
    create table(:product_attributes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :product_id, references(:products, type: :uuid, on_delete: :nothing)
      add :attribute_id, references(:attributes, type: :uuid, on_delete: :nothing)
      add :value, :string
      add :cardinality, :string
      timestamps()
    end

    create index(:product_attributes, [:product_id])
    create index(:product_attributes, [:attribute_id])
  end
end
