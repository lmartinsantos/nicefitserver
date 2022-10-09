defmodule Nicefitserver.Repository.Entities.UserPosition do

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "user_positions" do
    field :date, :date
    field :position_id, :binary_id
    field :user_id, :binary_id
    field :value, :integer
    field :cardinality, Ecto.Enum, values: [:factual, :estimated]

    timestamps()
  end

  @doc false
  def changeset(user_position, attrs) do
    user_position
    |> cast(attrs, [:user_id, :position_id, :date, :cardinality, :value])
    |> validate_required([:user_id, :position_id, :date, :cardinality, :value])
  end
end
