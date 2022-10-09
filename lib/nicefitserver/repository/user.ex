defmodule Nicefitserver.Repository.User do
  alias Nicefitserver.Repository.Entities, as: Entities
  alias Nicefitserver.Repository.UserAttribute, as: UserAttribute
  alias Nicefitserver.Repository.UserPosition, as: UserPosition
  alias Nicefitserver.Repo
  import Ecto.Query
  alias __MODULE__

  @type t :: %User{
          id: :uuid,
          first_seen: Date.t(),
          last_seen: Date.t(),
          positions: tuple(),
          attributes: tuple(),
        }

  @derive Jason.Encoder
  defstruct [
    :id,
    :first_seen,
    :last_seen,
    :positions,
    :attributes
  ]

  def load() do
    users = Repo.all(
      from p in Entities.User,
        select: %User{:id => p.id, :first_seen => p.inserted_at, :last_seen => p.updated_at}
    )
    Enum.map(users, fn e ->
      build_user(e)
    end)
  end

  def load(%{:limit => limit}) do
    users = Repo.all(
      from p in Entities.User,
        select: %User{:id => p.id, :first_seen => p.inserted_at, :last_seen => p.updated_at},
        limit: ^limit
    )
    Enum.map(users, fn e ->
      build_user(e)
    end)
  end

  def load(%{:id => id}) do
    user = Repo.one(
      from p in Entities.User,
        where: p.id == ^id,
        select: %User{:id => p.id, :first_seen => p.inserted_at, :last_seen => p.updated_at}
    )
    build_user(user)
  end


  def build_user(user) do

    %User{
      id: user.id,
      first_seen: user.first_seen,
      last_seen: user.last_seen,
      positions: UserPosition.load(%{:user_id => user.id}),
      attributes: UserAttribute.load(%{:user_id => user.id})
    }
  end
end
