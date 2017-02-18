defmodule Web.ViewTest do
  use ExUnit.Case, async: true
  alias Web.View

  test "renders 404.json" do
    assert View.render("404.json", []) ==
           ~s({"errors":{"detail":"Page not found"}})
  end

  test "render 500.json" do
    assert View.render("500.json", []) ==
           ~s({"errors":{"detail":"Internal server error"}})
  end

  test "render ok.json" do
    assert View.render("ok.json", []) == ~s({"status":"ok"})
  end
end
