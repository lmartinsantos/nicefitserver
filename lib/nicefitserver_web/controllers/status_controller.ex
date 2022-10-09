defmodule NicefitserverWeb.StatusController do
  use NicefitserverWeb, :controller

  def index(conn, %{}) do

    json(conn, "ok")
  end
end
