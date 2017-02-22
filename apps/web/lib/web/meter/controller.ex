defmodule Web.Meter.Controller do
  use Web.Web, :controller

  alias Web.ChangesetView
  alias Web.Meter.Params

  def create(conn, params) do
    changeset = Params.changeset(params, :create)
    if changeset.valid? do
      conn
      |> put_status(201)
      |> render("ok.json")
    else
      conn
      |> put_status(400)
      |> render(ChangesetView, "error.json", changeset: changeset)
    end
  end
end
