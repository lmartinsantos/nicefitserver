defmodule NicefitserverWeb.Schemas.AssignVariantResponse do
  require OpenApiSpex
  alias OpenApiSpex.{Reference, Schema}

  OpenApiSpex.schema(%{
    title: "AssignVariantResponse",
    description: "Response from a AssignVariant Call",
    type: :object,
    properties: %{
      user_id: %Schema{type: :string, description: "User UUID"},
      product_id: %Schema{type: :string, description: "Product UUID"},
      product_variant_id: %Schema{type: :string, description: "Product Variant UUID"},
      variant: %Schema{type: :string, description: "Variant name assigned"},
      cardinality: %Schema{type: :string, description: "Cardinality of the assignment (factual or estimated)"},
    },
    required: [:user_id, :product_id, :method],
    example: %{
      user_id: "_an_uuid_of_user",
      product_id: "_an_uuid_of_product",
      product_variant_id: "_an_uuid_of_product_variant",
      variant: "XL",
      cardinality: "factual"
    }
  })
end
