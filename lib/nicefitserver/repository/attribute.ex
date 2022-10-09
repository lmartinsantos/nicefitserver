defmodule Nicefitserver.Repository.Attribute do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %Attribute{
          id: :uuid,
          name: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :name
  ]

  def load(%{:id => id}) do
    Repo.one(
      from p in Entities.Attribute,
        where: p.id == ^id,
        select: %Attribute{:id => p.id, :name => p.name}
    )
  end

  def findIn(map,attribute_name) do
    Enum.at(Enum.filter(map.attributes, fn e ->
      e.attribute.name == attribute_name
    end),0)
  end
end
