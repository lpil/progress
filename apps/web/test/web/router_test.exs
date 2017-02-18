defmodule Web.RouterTest do
  use ExUnit.Case, async: true
  use Web.ConnCase

  test "GET /__health__" do
    conn = get(build_conn(), "/__health__")
    assert json_response(conn, 200) == %{"status" => "ok"}
  end

  test "GET an unknown route" do
    conn = get(build_conn(), "/nothing-here")
    assert json_response(conn, 404) ==
      %{"errors" => %{"detail" => "Page not found"}}
  end

  describe "POST /meter/:id, creation of meters" do
    test "body params are validated" do
      response =
        build_conn()
        |> post("/meter/video-1", %{total: "-50"})
        |> json_response(400)
      assert response ==
        %{"errors" =>
          %{"total" => ["must be greater than 0"],
            "unit" => ["can't be blank"]}}
    end

    @tag :skip
    test "successful creation" do
      body = %{total: 1000, unit: "megabytes"}
      response =
        build_conn()
        |> post("/meter/video-1", body)
        |> json_response(201)
      assert response ==
        %{"meter" =>
          %{"id" => "video-1",
            "total" => 1000,
            "progress" => 0,
            "unit" => "megabytes"}}
    end
  end
end
