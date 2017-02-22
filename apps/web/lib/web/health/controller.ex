defmodule Web.Health.Controller do
  use Web.Web, :controller

  def index(conn, _params) do
    render conn, "index.json"
  end
end
