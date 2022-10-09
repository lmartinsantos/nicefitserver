defmodule NicefitserverWeb.Schemas.CatalogResponse do
  require OpenApiSpex
  alias OpenApiSpex.{Reference, Schema}

  OpenApiSpex.schema(%{
    title: "CatalogResponse",
    description: "Response from a Catalog Call",
    type: :object,
    properties: %{
      user_id: %Schema{type: :array, description: "Array of Objects"},
    }
  })
end
