defmodule Web.Router do
  use Plug.Router
  alias Web.View

  plug :json_content_type
  plug :match
  plug :dispatch

  #
  # Routes
  #

  get "/__health__" do
    send_resp(conn, 200, View.render("ok.json"))
  end

  match _ do
    send_resp(conn, 404, View.render("404.json"))
  end

  #
  # Private
  #

  defp json_content_type(conn, _) do
    put_resp_content_type(conn, "application/json")
  end
end
