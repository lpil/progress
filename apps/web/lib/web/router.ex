defmodule Web.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/hello" do
    conn
    |> send_resp(200, "world")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
