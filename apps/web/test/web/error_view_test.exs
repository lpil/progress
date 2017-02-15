defmodule Web.ErrorViewTest do
  use Web.ConnCase, async: true

  import Phoenix.View, only: [render: 3]

  test "renders 404.json" do
    assert render(Web.ErrorView, "404.json", []) ==
           %{errors: %{detail: "Page not found"}}
  end

  test "render 500.json" do
    assert render(Web.ErrorView, "500.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end

  test "render any other" do
    assert render(Web.ErrorView, "505.json", []) ==
           %{errors: %{detail: "Internal server error"}}
  end
end
