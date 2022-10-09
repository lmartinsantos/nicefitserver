defmodule Nicefitserver.Repository.Entities.ProductAttribute do

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "product_attributes" do
    field :product_id, :binary_id
    field :attribute_id, :binary_id
    field :value, :string
    field :cardinality, Ecto.Enum, values: [:factual, :estimated]
    timestamps()
  end

  @doc false
  def changeset(product_attribute, attrs) do
    product_attribute
    |> cast(attrs, [])
    |> validate_required([])
  end
end
