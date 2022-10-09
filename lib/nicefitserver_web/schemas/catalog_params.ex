defmodule NicefitserverWeb.Schemas.CatalogParams do
  require OpenApiSpex
  alias OpenApiSpex.{Reference, Schema}
  @behaviour OpenApiSpex.Schema

  def schema() do
    %Schema{
      title: "CatalogParams",
      description: "Parameters for a Catalog Call",
      type: :object,
      properties: %{
        entity: %Schema{type: :string, description: "Entity Name"},
        reference: %Schema{type: :string, description: "Optional Entity reference"},
      },
      required: [:entity],
      example: %{
        entity: "user",
        reference: nil
      }
    }
  end
end
