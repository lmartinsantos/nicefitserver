defmodule Nicefitserver.Repository.Entities.ProductVariantAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "product_variant_attributes" do
    field :cardinality, Ecto.Enum, values: [:factual, :estimated]
    field :value, :string
    field :product_variant_id, :binary_id
    field :attribute_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(product_variant_attribute, attrs) do
    product_variant_attribute
    |> cast(attrs, [:value, :cardinality])
    |> validate_required([:value, :cardinality])
  end
end
