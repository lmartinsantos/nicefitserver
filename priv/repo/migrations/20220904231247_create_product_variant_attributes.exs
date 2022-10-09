defmodule Nicefitserver.Repo.Migrations.CreateProductVariantAttributes do
  use Ecto.Migration

  def change do
    create table(:product_variant_attributes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :value, :string
      add :cardinality, :string
      add :product_variant_id, references(:product_variants, type: :uuid, on_delete: :nothing)
      add :attribute_id, references(:attributes, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:product_variant_attributes, [:product_variant_id])
    create index(:product_variant_attributes, [:attribute_id])
  end
end
