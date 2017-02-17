defmodule Web.View do
  @moduledoc """
  Views relating to errors.
  """

  def render(view, assigns \\ %{})

  def render("ok.json", _assigns) do
    ~s({"status":"ok"})
  end

  def render("404.json", _assigns) do
    ~s({"errors":{"detail":"Page not found"}})
  end

  def render("500.json", _assigns) do
    ~s({"errors":{"detail":"Internal server error"}})
  end

  def render(_, assigns) do
    render("500.json", assigns)
  end
end
