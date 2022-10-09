defmodule Nicefitserver.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :reference, :string
      add :name, :string
      add :status, :integer

      timestamps()
    end

    create(
      unique_index( :products, ~w(reference)a, name: :index_for_reference_duplicates )
    )
  end

end
