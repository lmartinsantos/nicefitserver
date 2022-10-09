defmodule NicefitserverWeb.Router do
  use NicefitserverWeb, :router
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {NicefitserverWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: NicefitserverWeb.ApiSpec
  end

  scope "/" do
    pipe_through :browser
    get "/", NicefitserverWeb.PageController, :index
    get "/status", NicefitserverWeb.StatusController, :index
    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI,
      path: "/api/openapi",
      default_model_expand_depth: 3,
      display_operation_id: true
  end

  scope "/api" do
    pipe_through :api
    post "/recommend", NicefitserverWeb.RecommendController, :recommend
    post "/assign", NicefitserverWeb.AssignController, :assign
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/api" do
      pipe_through :api
      get "/catalog/:entity", NicefitserverWeb.RepositoryController, :catalog
      get "/catalog/:entity/:reference", NicefitserverWeb.RepositoryController, :catalog
      get "/openapi", OpenApiSpex.Plug.RenderSpec, []
    end

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: NicefitserverWeb.Telemetry
    end
  end
end
