defmodule Nicefitserver.Repo.Migrations.CreateProductVariants do
  use Ecto.Migration

  def change do
    create table(:product_variants, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :series, :string
      add :product_id, references(:products, type: :uuid, on_delete: :nothing)

      timestamps()
    end

    create index(:product_variants, [:product_id])
  end
end
