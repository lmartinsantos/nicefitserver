defmodule Nicefitserver.Repository.UserProduct do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repository.Product, as: Product
  alias Nicefitserver.Repository.ProductVariant, as: ProductVariant
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %UserProduct{
          id: :uuid,
          user_id: :uuid,
          product_id: :uuid,
          product_variant_id: :uuid,
          product: map(),
          product_variant: map(),
          cardinality: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :user_id,
    :product_id,
    :product_variant_id,
    :product,
    :product_variant,
    :cardinality
  ]

  def load(%{:id => id}) do
    user_product =
      Repo.one(
        from p in Entities.UserPosition,
          where: p.id == ^id,
          select: %UserPosition{
            :id => p.id,
            :product_id => p.product_id,
            :product_variant_id => p.product_variant_id,
            :user_id => p.user_id,
            :cardinality => p.cardinality
          }
      )

    Map.put(user_product, :product, Product.load(%{:id => user_product.product_id}))

    Map.put(
      user_product,
      :product_variant_id,
      ProductVariant.load(%{:id => user_product.product_variant_id})
    )
  end

  def load(%{:user_id => user_id}) do
    user_products =
      Repo.one(
        from p in Entities.UserPosition,
          where: p.user_id == ^user_id,
          select: %UserPosition{
            :id => p.id,
            :product_id => p.product_id,
            :product_variant_id => p.product_variant_id,
            :user_id => p.user_id,
            :cardinality => p.cardinality
          }
      )

    Enum.map(user_products, fn user_product ->
      Map.put(user_product, :product, Product.load(%{:id => user_product.product_id}))

      Map.put(
        user_product,
        :product_variant_id,
        ProductVariant.load(%{:id => user_product.product_variant_id})
      )
    end)
  end

  def load(%{:product_id => product_id}) do
    user_products =
      Repo.one(
        from p in Entities.UserPosition,
          where: p.product_id == ^product_id,
          select: %UserPosition{
            :id => p.id,
            :product_id => p.product_id,
            :product_variant_id => p.product_variant_id,
            :user_id => p.user_id,
            :cardinality => p.cardinality
          }
      )

    Enum.map(user_products, fn user_product ->
      Map.put(user_product, :product, Product.load(%{:id => user_product.product_id}))

      Map.put(
        user_product,
        :product_variant_id,
        ProductVariant.load(%{:id => user_product.product_variant_id})
      )
    end)
  end

  def load(%{:product_id => product_id, :user_id => user_id}) do
    user_products =
      Repo.one(
        from p in Entities.UserPosition,
          where: p.product_id == ^product_id and p.user_id == ^user_id,
          select: %UserPosition{
            :id => p.id,
            :product_id => p.product_id,
            :product_variant_id => p.product_variant_id,
            :user_id => p.user_id,
            :cardinality => p.cardinality
          }
      )

    Enum.map(user_products, fn user_product ->
      Map.put(user_product, :product, Product.load(%{:id => user_product.product_id}))

      Map.put(
        user_product,
        :product_variant_id,
        ProductVariant.load(%{:id => user_product.product_variant_id})
      )
    end)
  end
end
