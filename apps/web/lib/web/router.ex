defmodule Web.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
    plug :put_resp_content_type_json
  end

  scope "/", Web do
    pipe_through :api

    get "/__health__", Health.Controller, :index

    resources "/meters", Meter.Controller, only: [:create]
  end

  #
  # Plugs
  #

  defp put_resp_content_type_json(conn, _opts) do
    put_resp_content_type(conn, "application/json")
  end
end
