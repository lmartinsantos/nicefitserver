defmodule NicefitserverWeb.RecommendController do
  use NicefitserverWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias NicefitserverWeb.Schemas.{RecommendVariantParams, RecommendVariantResponse}

  # plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true

  tags ["recommendations"]

  operation :recommend,
    summary: "Recommend Variant",
    request_body: {"Recommendation Parameters", "application/json", RecommendVariantParams},
    responses: %{
      200 => {"RecommendVariantResponse", "application/json", RecommendVariantResponse}
    }

  def recommend(conn, %{"user_id" => user_id, "product_id" => product_id, "method" => method}) do
    user = Nicefitserver.Repository.User.load(%{:id => user_id})
    product = Nicefitserver.Repository.Product.load(%{:id => product_id})

    recommendation =
      Nicefitserver.Recommender.Recommend.recommend_variant(%{
        :method => method,
        :user => user,
        :product => product
      })

    case recommendation do
      {:ok, r} ->
        json(conn, %{
          user_id: user_id,
          product_id: product_id,
          product_reference: product.reference,
          recommended_variant: r.recommended_variant,
          recommendation_output: r
        })
      _ ->
        json(conn, [])
    end
  end
end
