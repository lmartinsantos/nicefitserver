defmodule Nicefitserver.Repository.UserPosition do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repository.Position, as: Position
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %UserPosition{
          id: :uuid,
          user_id: :uuid,
          position_id: :uuid,
          position: map(),
          value: integer,
          cardinality: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :user_id,
    :position_id,
    :position,
    :value,
    :cardinality
  ]

  def load(%{:id => id}) do
    user_position =
      Repo.one(
        from p in Entities.UserPosition,
          where: p.id == ^id,
          select: %UserPosition{
            :id => p.id,
            :value => p.value,
            :position_id => p.position_id,
            :user_id => p.user_id,
            :cardinality => p.cardinality
          }
      )

    Map.put(user_position, :position, Position.load(%{:id => user_position.position_id}))
  end

  def load(%{:user_id => user_id}) do
    user_positions =
      Repo.all(
        from p in Entities.UserPosition,
          where: p.user_id == ^user_id,
          select: %UserPosition{
            :id => p.id,
            :value => p.value,
            :position_id => p.position_id,
            :user_id => p.user_id,
            :cardinality => p.cardinality
          }
      )

    Enum.map(user_positions, fn e ->
      Map.put(e, :position, Position.load(%{:id => e.position_id}))
    end)
  end
end
