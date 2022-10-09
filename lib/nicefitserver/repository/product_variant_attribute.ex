defmodule Nicefitserver.Repository.ProductVariantAttribute do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repository.Attribute, as: Attribute
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %ProductVariantAttribute{
          id: :uuid,
          product_variant_id: :uuid,
          attribute_id: :uuid,
          value: String.t(),
          cardinality: atom()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :product_variant_id,
    :attribute_id,
    :attribute,
    :cardinality,
    :value
  ]

  def load(%{:id => id}) do
    product_variant_attribute =
      Repo.one(
        from p in Entities.ProductVariantAttribute,
          where: p.id == ^id,
          select: %ProductVariantAttribute{
            :id => p.id,
            :product_variant_id => p.product_variant_id,
            :Attribute_id => p.attribute_id,
            :value => p.value,
            :cardinality => p.cardinality,
            :series => p.series
          }
      )

    Map.put(
      product_variant_attribute,
      :attribute,
      Attribute.load(%{id => product_variant_attribute.attribute_id})
    )
  end

  def load(%{:product_variant_id => product_variant_id}) do
    product_variants =
      Repo.all(
        from p in Entities.ProductVariantAttribute,
          where: p.product_variant_id == ^product_variant_id,
          select: %ProductVariantAttribute{
            :id => p.id,
            :product_variant_id => p.product_variant_id,
            :Attribute_id => p.attribute_id,
            :value => p.value,
            :cardinality => p.cardinality,
            :series => p.series
          }
      )

    Enum.map(product_variants, fn e ->
      Map.put(e, :attribute, Attribute.load(%{:id => e.attribute_id}))
    end)
  end
end
