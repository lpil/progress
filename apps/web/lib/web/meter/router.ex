defmodule Web.Meter.Router do
  use Plug.Router
  alias Web.View
  alias Web.Meter.CreateParams

  plug :match
  plug :dispatch

  post "/:id" do
    changeset = conn.params |> CreateParams.changeset()
    if changeset.valid? do
      send_resp(conn, 201, View.render("ok.json"))
    else
      send_resp(conn, 400, View.render("changeset-errors.json", changeset))
    end
  end

  match _, do: Web.Router.not_found(conn)
end
