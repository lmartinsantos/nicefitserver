defmodule Nicefitserver.Repository.Entities.Position do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "positions" do
    field :dimensions, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(position, attrs) do
    position
    |> cast(attrs, [:name, :dimensions])
    |> validate_required([:name, :dimensions])
  end
end
