defmodule Nicefitserver.Repository.ProductAttribute do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repository.Attribute, as: Attribute
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %ProductAttribute{
          id: :uuid,
          product_id: :uuid,
          attribute_id: :uuid,
          value: String.t(),
          attribute: map()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :product_id,
    :attribute_id,
    :value,
    :attribute
  ]

  def load(%{:id => id}) do
    product_attribute =
      Repo.one(
        from p in Entities.ProductAttribute,
          where: p.id == ^id,
          select: %ProductAttribute{
            :id => p.id,
            :product_id => p.product_id,
            :attribute_id => p.attribute_id,
            :value => p.value
          }
      )

    attribute = Attribute.load(%{:id => product_attribute.attribute_id})
    Map.put(product_attribute, :attribute, attribute)
  end

  def load(%{:product_id => product_id}) do
    product_attributes =
      Repo.all(
        from p in Entities.ProductAttribute,
          where: p.product_id == ^product_id,
          select: %ProductAttribute{
            :id => p.id,
            :product_id => p.product_id,
            :attribute_id => p.attribute_id,
            :value => p.value
          }
      )

    Enum.map(product_attributes, fn p ->
      attribute = Attribute.load(%{:id => p.attribute_id})
      Map.put(p, :attribute, attribute)
    end)
  end
end
