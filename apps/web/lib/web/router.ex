defmodule Web.Router do
  use Plug.Router
  alias Web.{View, Meter}

  #
  # Router
  #

  plug :put_resp_content_type_json
  plug :match
  plug :dispatch

  forward "/meter", to: Meter.Router

  get "/__health__" do
    send_resp(conn, 200, View.render("ok.json"))
  end

  match _, do: not_found(conn)

  #
  # Functions
  #

  def not_found(conn) do
    send_resp(conn, 404, View.render("404.json"))
  end

  #
  # Private
  #

  defp put_resp_content_type_json(conn, _opts) do
    put_resp_content_type(conn, "application/json")
  end
end
