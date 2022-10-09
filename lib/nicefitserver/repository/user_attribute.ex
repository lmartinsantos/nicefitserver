defmodule Nicefitserver.Repository.UserAttribute do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repository.Attribute, as: Attribute
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %UserAttribute{
          id: :uuid,
          user_id: :uuid,
          attribute: map(),
          attribute_id: :uuid,
          optional: boolean(),
          value: String.t(),
          cardinality: String.t()
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :user_id,
    :attribute_id,
    :attribute,
    :optional,
    :value,
    :cardinality
  ]

  def load(%{:id => id}) do
    user_attribute =
      Repo.one(
        from p in Entities.UserAttribute,
          where: p.id == ^id,
          select: %UserAttribute{
            :id => p.id,
            :value => p.value,
            :attribute_id => p.attribute_id,
            :optional => p.optional,
            :user_id => p.user_id,
            :cardinality => p.cardinality
          }
      )
    Map.put(user_attribute, :attribute, Attribute.load(%{:id => user_attribute.attribute_id}))
  end

  def load(%{:user_id => user_id}) do
    user_attributes =
      Repo.all(
        from p in Entities.UserAttribute,
          where: p.user_id == ^user_id,
          select: %UserAttribute{
            :id => p.id,
            :value => p.value,
            :attribute_id => p.attribute_id,
            :optional => p.optional,
            :user_id => p.user_id,
            :cardinality => p.cardinality
          }
      )

    Enum.map(user_attributes, fn e ->
      Map.put(e, :attribute, Attribute.load(%{:id => e.attribute_id}))
    end)
  end
end
