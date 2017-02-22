defmodule Web.ChangesetView do
  use Web.Web, :view

  @doc """
  Traverses and translates changeset errors.

  """
  def interpolate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &interpolate_error/1)
  end

  def render("error.json", %{changeset: changeset}) do
    # When encoded, the changeset returns its errors
    # as a JSON object. So we just pass it forward.
    %{errors: interpolate_errors(changeset)}
  end

  #
  # Private
  #

  defp interpolate_error({message, values}) do
    Enum.reduce(values, message, fn({k, v}, string) ->
      String.replace(string, "%{#{k}}", to_string(v))
    end)
  end
  defp interpolate_error(message) do
    message
  end
end
