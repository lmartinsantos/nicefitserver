defmodule Nicefitserver.Repository.ProductVariantPosition do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repository.Position, as: Position
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %ProductVariantPosition{
          id: :uuid,
          product_variant_id: :uuid,
          position_id: :uuid,
          value: integer,
          cardinality: atom()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :product_variant_id,
    :position_id,
    :position,
    :cardinality,
    :value
  ]

  def load(%{:id => id}) do
    product_variant_position =
      Repo.one(
        from p in Entities.ProductVariantPosition,
          where: p.id == ^id,
          select: %ProductVariantPosition{
            :id => p.id,
            :product_variant_id => p.product_variant_id,
            :position_id => p.position_id,
            :value => p.value,
            :cardinality => p.cardinality
          }
      )

    Map.put(
      product_variant_position,
      :position,
      Position.load(%{id => product_variant_position.position_id})
    )
  end

  def load(%{:product_variant_id => product_variant_id}) do
    product_variants =
      Repo.all(
        from p in Entities.ProductVariantPosition,
          where: p.product_variant_id == ^product_variant_id,
          select: %ProductVariantPosition{
            :id => p.id,
            :product_variant_id => p.product_variant_id,
            :position_id => p.position_id,
            :value => p.value,
            :cardinality => p.cardinality
          }
      )

    Enum.map(product_variants, fn e ->
      Map.put(e, :position, Position.load(%{:id => e.position_id}))
    end)
  end
end
