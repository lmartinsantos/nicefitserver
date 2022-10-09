defmodule Nicefitserver.Repository.Entities.ProductTags do

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "product_tags" do
    field :cardinality, Ecto.Enum, values: [:factual, :estimated]
    field :name, :string
    field :value, :string
    field :product_id, :binary_id
    timestamps()
  end

  @doc false
  def changeset(product_tags, attrs) do
    product_tags
    |> cast(attrs, [:name, :value, :cardinality])
    |> validate_required([:name, :value, :cardinality])
  end
end
