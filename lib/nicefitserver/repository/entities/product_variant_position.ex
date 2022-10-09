defmodule Nicefitserver.Repository.Entities.ProductVariantPosition do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "product_variant_positions" do
    field :cardinality, Ecto.Enum, values: [:factual, :estimated]
    field :value, :integer
    field :product_variant_id, :binary_id
    field :position_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(product_variant_position, attrs) do
    product_variant_position
    |> cast(attrs, [:value, :cardinality])
    |> validate_required([:value, :cardinality])
  end
end
