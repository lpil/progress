defmodule Web.Meter.View do
  use Web.Web, :view

  def render("index.json", _assigns) do
    %{status: "ok"}
  end
end
