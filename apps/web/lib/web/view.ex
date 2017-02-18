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

  def render("changeset-errors.json", changeset) do
    errors =
      changeset.errors
      |> Enum.map(fn({field, detail}) ->
        {to_string(field), [render_detail(detail)]}
      end)
      |> Enum.into(%{})
    errors_map = Map.merge(%{}, errors, fn(_k, v1, v2) -> [v2|v1] end)
    Poison.encode!(%{errors: errors_map})
  end

  #
  # Private
  #

  defp render_detail({message, values}) do
    interpolate = fn({k, v}, string) ->
      String.replace(string, "%{#{k}}", to_string(v))
    end
    Enum.reduce(values, message, interpolate)
  end
  defp render_detail(message) do
    message
  end
end
