defmodule Nicefitserver.Repository.Entities.Product do

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "products" do
    field :name, :string
    field :reference, :string
    field :status, :integer

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:reference, :name, :status])
    |> validate_required([:reference, :name, :status])
    |> unique_constraint(:reference, name: :index_for_reference_duplicates)
  end
end
