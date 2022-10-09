defmodule Nicefitserver.Repository.Tag do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %Tag{
          id: :uuid,
          cardinality: atom(),
          product_id: integer,
          name: String.t(),
          value: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :cardinality,
    :product_id,
    :name,
    :value
  ]

  def load(%{:id => id}) do
    Repo.one(
      from p in Entities.Product,
        where: p.id == ^id,
        select: %Tag{
          :id => p.id,
          :name => p.name,
          :cardinality => p.cardinality,
          :value => p.value
        }
    )
  end

  def load(%{:product_id => product_id}) do
    Repo.all(
      from p in Entities.ProductTags,
        where: p.product_id == ^product_id,
        select: %Tag{
          :id => p.id,
          :name => p.name,
          :cardinality => p.cardinality,
          :value => p.value,
          :product_id => p.product_id
        }
    )
  end
end
