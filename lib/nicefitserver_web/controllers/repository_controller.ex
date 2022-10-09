defmodule NicefitserverWeb.RepositoryController do
  use NicefitserverWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias NicefitserverWeb.Schemas.{CatalogParams, CatalogResponse}

  # plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true

  tags ["repository"]

  operation :catalog,
  summary: "Repository Catalog",
  request_body: {"Catalog Parameters", "application/json", CatalogParams},
  responses: %{
    200 => {"CatalogResponse", "application/json", CatalogResponse}
  }

  def catalog(conn, %{"entity" => "user"}) do
    users = Nicefitserver.Repository.User.load()
    json(conn, users)
  end

  def catalog(conn, %{"entity" => "user", "reference" => id}) do
    users = Nicefitserver.Repository.User.load(%{:id => id})
    json(conn, users)
  end

  def catalog(conn, %{"entity" => "product"}) do
    products = Nicefitserver.Repository.Product.load()
    json(conn, products)
  end

  def catalog(conn, %{"entity" => "product", "reference" => reference}) do
    product = Nicefitserver.Repository.Product.load(%{:reference => reference})
    json(conn, product)
  end
end
