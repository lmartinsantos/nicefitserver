defmodule NicefitserverWeb.PageController do
  use NicefitserverWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
