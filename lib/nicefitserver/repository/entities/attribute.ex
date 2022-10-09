defmodule Nicefitserver.Repository.Entities.Attribute do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "attributes" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(attribute, attrs) do
    attribute
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
