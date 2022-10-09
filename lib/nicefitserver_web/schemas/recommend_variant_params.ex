defmodule NicefitserverWeb.Schemas.RecommendVariantParams do
  require OpenApiSpex
  alias OpenApiSpex.{Reference, Schema}
  @behaviour OpenApiSpex.Schema

  def schema() do
    %Schema{
      title: "RecommendVariantParams",
      description: "Parameters for a RecommendVariant Call",
      type: :object,
      properties: %{
        user_id: %Schema{type: :string, description: "User UUID"},
        product_id: %Schema{type: :string, description: "Product UUID"},
        method: %Schema{type: :string, description: "recommendation method"}
      },
      required: [:user_id, :product_id, :method],
      example: %{
        user_id: "_an_uuid_of_user",
        product_id: "_an_uuid_of_product",
        method: "geometric"
      }
    }
  end
end
