defmodule Nicefitserver.Repository.ProductVariant do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repository.ProductVariantPosition, as: ProductVariantPosition
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %ProductVariant{
          id: :uuid,
          name: String.t(),
          product_id: :uuid,
          positions: tuple(),
          series: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :product_id,
    :name,
    :positions,
    :series
  ]

  def load(%{:id => id}) do
    product_variant =
      Repo.one(
        from p in Entities.ProductVariant,
          where: p.id == ^id,
          select: %ProductVariant{:id => p.id, :name => p.name, :product_id => p.product_id}
      )

    Map.put(
      product_variant,
      :positions,
      ProductVariantPosition.load(%{:product_variant_id => product_variant.id})
    )
  end

  def load(%{:product_id => product_id, :name => name}) do
    product_variant =
      Repo.one(
        from p in Entities.ProductVariant,
          where: p.product_id == ^product_id and p.name == ^name,
          select: %ProductVariant{:id => p.id, :name => p.name, :product_id => p.product_id}
      )

    Map.put(
      product_variant,
      :positions,
      ProductVariantPosition.load(%{:product_variant_id => product_variant.id})
    )
  end

  def load(%{:product_id => product_id}) do
    product_variants =
      Repo.all(
        from p in Entities.ProductVariant,
          where: p.product_id == ^product_id,
          select: %ProductVariant{:id => p.id, :name => p.name, :product_id => p.product_id}
      )

    Enum.map(product_variants, fn e ->
      Map.put(e, :positions, ProductVariantPosition.load(%{:product_variant_id => e.id}))
    end)
  end
end
