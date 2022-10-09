defmodule Nicefitserver.Repo.Migrations.CreateProductVariantPositions do
  use Ecto.Migration

  def change do
    create table(:product_variant_positions, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :value, :integer
      add :cardinality, :string
      add :product_variant_id, references(:product_variants, type: :uuid, on_delete: :nothing)
      add :position_id, references(:positions, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:product_variant_positions, [:product_variant_id])
    create index(:product_variant_positions, [:position_id])
  end
end
