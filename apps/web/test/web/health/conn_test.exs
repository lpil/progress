defmodule Web.Health.ConnTest do
  use ExUnit.Case, async: true
  use Web.ConnCase

  test "GET /__health__" do
    conn = get(build_conn(), "/__health__")
    assert json_response(conn, 200) ==
      %{"status" => "ok"}
  end

  test "GET an unknown route" do
    conn = get(build_conn(), "/nothing-here")
    assert json_response(conn, 404) ==
      %{"errors" => %{"detail" => "Page not found"}}
  end
end
