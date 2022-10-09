defmodule Nicefitserver.Repository.Entities.UserProduct do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "user_products" do
    field :date, :date
    field :product_id, :binary_id
    field :product_variant_id, :binary_id
    field :user_id, :binary_id
    field :cardinality, Ecto.Enum, values: [:factual, :estimated]
    timestamps()
  end

  @doc false
  def changeset(user_product, attrs) do
    user_product
    |> cast(attrs, [:user_id, :product_id, :product_variant_id, :date, :cardinality])
    |> validate_required([:user_id, :product_id, :product_variant_id, :date, :cardinality])
  end
end
