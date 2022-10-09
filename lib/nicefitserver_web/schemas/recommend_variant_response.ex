defmodule NicefitserverWeb.Schemas.RecommendVariantResponse do
  require OpenApiSpex
  alias OpenApiSpex.{Reference, Schema}

  OpenApiSpex.schema(%{
    title: "RecommendVariantResponse",
    description: "Response from a RecommendVariant Call",
    type: :object,
    properties: %{
      user_id: %Schema{type: :string, description: "User UUID"},
      product_id: %Schema{type: :string, description: "Product UUID"},
      product_reference: %Schema{type: :string, description: "Product Reference"},
      recommended_variant: %Schema{type: :string, description: "Recommended Product Variant"},
      recommendation_output: %Schema{
        type: :tuple,
        description: "Recommendation Algorithm Output"
      }
    },
    required: [:user_id, :product_id, :method],
    example: %{
      user_id: "_an_uuid_of_user",
      product_id: "_an_uuid_of_product",
      method: "geometric"
    }
  })
end
