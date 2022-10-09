defmodule NicefitserverWeb.Schemas.AssignVariantParams do
  require OpenApiSpex
  alias OpenApiSpex.{Reference, Schema}
  @behaviour OpenApiSpex.Schema

  def schema() do
    %Schema{
      title: "AssignVariantParams",
      description: "Parameters for a AssingVariant Call",
      type: :object,
      properties: %{
        user_id: %Schema{type: :string, description: "User UUID"},
        product_id: %Schema{type: :string, description: "Product UUID"},
        variant: %Schema{type: :string, description: "Variant name to assign"},
        cardinality: %Schema{
          type: :string,
          description: "Cardinality of the assignment (factual or estimated)"
        }
      },
      required: [:user_id, :product_id, :variant, :cardinality],
      example: %{
        user_id: "_an_uuid_of_user",
        product_id: "_an_uuid_of_product",
        variant: "XL",
        cardinality: "factual"
      }
    }
  end
end
