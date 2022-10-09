defmodule Nicefitserver.Repository.Entities.ProductVariant do

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "product_variants" do
    field :name, :string
    field :series, :string, default: "default"
    field :product_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(product_variant, attrs) do
    product_variant
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
