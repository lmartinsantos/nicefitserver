defmodule Nicefitserver.Repository.Entities.UserAttribute do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "user_attributes" do
    field :attribute_id, :binary_id
    field :date, :date
    field :optional, :boolean, default: false
    field :user_id, :binary_id
    field :value, :string
    field :cardinality, Ecto.Enum, values: [:factual, :estimated]

    timestamps()
  end

  @doc false
  def changeset(user_attribute, attrs) do
    user_attribute
    |> cast(attrs, [:user_id, :attribute_id, :date, :cardinality, :value, :optional])
    |> validate_required([:user_id, :attribute_id, :date, :cardinality, :value, :optional])
  end
end
