
defmodule Nicefitserver.Repo.Migrations.CreateUserProducts do
  use Ecto.Migration

  def change do
    create table(:user_products, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)
      add :product_id, references(:products, type: :uuid, on_delete: :nothing)
      add :product_variant_id, references(:product_variants, type: :uuid, on_delete: :nothing)
      add :cardinality, :string
      timestamps()
    end
  end
end
