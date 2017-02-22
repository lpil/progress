defmodule Web.Meter.Params do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :id, :string
    field :unit, :string
    field :total, :integer
    field :progress, :integer
  end

  def changeset(params, :create) do
    %__MODULE__{}
    |> cast(params, __schema__(:fields))
    |> validate_required([:id, :unit, :total])
    |> validate_number(:total, greater_than: 0)
    |> validate_number(:progress, greater_than: -1)
    |> validate_id_format()
  end

  defp validate_id_format(changeset) do
    id = get_field(changeset, :id) || ""
    if id =~ ":::" do
      add_error(changeset, :id, "cannot contain `:::`")
    else
      changeset
    end
  end
end
