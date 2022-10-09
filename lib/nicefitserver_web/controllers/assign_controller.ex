defmodule NicefitserverWeb.AssignController do
  use NicefitserverWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias NicefitserverWeb.Schemas.{AssignVariantParams, AssignVariantResponse}
  alias Nicefitserver.Repository.Entities.UserProduct
  alias Nicefitserver.Repository.ProductVariant
  alias Nicefitserver.Repo

  # plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true

  tags ["assignations"]

  operation :assign,
    summary: "Assign Variant",
    request_body: {"Assignation Parameters", "application/json", AssignVariantParams},
    responses: %{
      200 => {"AssignVariantResponse", "application/json", AssignVariantResponse}
    }

  def assign(conn, %{
        "user_id" => user_id,
        "product_id" => product_id,
        "variant" => variant,
        "cardinality" => cardinality
      }) do
    product_variant = ProductVariant.load(%{:product_id => product_id, :name => variant})

    cardinality_atom =
      case cardinality do
        "factual" -> :factual
        "estimated" -> :estimated
        _ -> :estimated
      end

    Repo.insert!(%Nicefitserver.Repository.Entities.UserProduct{
      product_id: product_id,
      product_variant_id: product_variant.id,
      user_id: user_id,
      cardinality: cardinality_atom
    })

    json(conn, %{
      user_id: user_id,
      product_id: product_id,
      product_variant_id: product_variant.id,
      variant: variant,
      cardinality: cardinality_atom
    })
  end
end
