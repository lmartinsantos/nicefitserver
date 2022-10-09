defmodule Nicefitserver.Repository.Product do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repo
  alias Nicefitserver.Repository.Tag, as: Tag
  alias Nicefitserver.Repository.ProductVariant, as: ProductVariant
  alias Nicefitserver.Repository.ProductAttribute, as: ProductAttribute

  import Ecto.Query
  alias __MODULE__

  @type t :: %Product{
          id: :uuid,
          reference: String.t(),
          name: String.t(),
          tags: tuple(),
          attributes: tuple(),
          variants: tuple()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :reference,
    :name,
    :tags,
    :attributes,
    :variants
  ]

  def get_references() do
    products =
      Repo.all(
        from p in Entities.Product,
          select: %{ :reference => p.reference}
      )
    Enum.map(products, fn p ->
      p.reference
    end)
  end

  def load() do
    products =
      Repo.all(
        from p in Entities.Product,
          select: %{:id => p.id, :name => p.name, :reference => p.reference}
      )
    Enum.map(products, fn p ->
      build_product(p)
    end)

  end

  def load(%{:id => id}) do
    product =
      Repo.one(
        from p in Entities.Product,
          where: p.id == ^id,
          select: %{:id => p.id, :name => p.name, :reference => p.reference}
      )

    build_product(product)
  end

  def load(%{:reference => reference}) do
    product =
      Repo.one(
        from p in Entities.Product,
          where: p.reference == ^reference,
          select: %{:id => p.id, :name => p.name, :reference => p.reference}
      )

    build_product(product)
  end

  def build_product(product) do
    %Product{
      :id => product.id,
      :reference => product.reference,
      :name => product.name,
      :tags => Tag.load(%{:product_id => product.id}),
      :variants => ProductVariant.load(%{:product_id => product.id}),
      :attributes => ProductAttribute.load(%{:product_id => product.id})
    }
  end
end
