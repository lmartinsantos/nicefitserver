defmodule Nicefitserver.Repository.Position do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %Position{
          id: :uuid,
          name: String.t(),
          dimensions: integer()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :name,
    :dimensions
  ]

  def load(%{:id => id}) do
    Repo.one(
      from p in Entities.Position,
        where: p.id == ^id,
        select: %Position{:id => p.id, :name => p.name, :dimensions => p.dimensions}
    )
  end

  def load() do
    Repo.all(
      from p in Entities.Position,
        select: %Position{:id => p.id, :name => p.name, :dimensions => p.dimensions}
    )
  end


  def findIn(map,position_name) do
    Enum.at(Enum.filter(map.positions, fn e ->
        position_name == e.position.name
    end),0)
  end
end
