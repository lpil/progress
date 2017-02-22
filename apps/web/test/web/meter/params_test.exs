defmodule Web.Meter.ParamsTest do
  use ExUnit.Case, async: true

  alias Web.Meter.Params
  import Params, only: [changeset: 2]

  @valid_params %{id: "video-1",
                  unit: "seconds",
                  total: "10000"}

  describe ".changeset/1" do
    test "fields are required" do
      changeset = changeset(%{}, :create)
      refute changeset.valid?
      assert [id: {"can't be blank", [validation: :required]},
              unit: {"can't be blank", [validation: :required]},
              total: {"can't be blank", [validation: :required]}] =
        changeset.errors
    end

    test "id cannot contain :::" do
      changeset = @valid_params
                  |> Map.put(:id, "video:::1")
                  |> changeset(:create)
      assert changeset.errors[:id] == {"cannot contain `:::`", []}
    end

    test "total must be a positive number" do
      assert_positive_number_field(:total)
    end

    test "total cannot be 0" do
      changeset = @valid_params
                  |> Map.put(:total, "0")
                  |> changeset(:create)
      assert changeset.errors[:total]
    end

    test "progress must be a positive number" do
      assert_positive_number_field(:progress)
    end

    test "progress can be 0" do
      changeset = @valid_params
                  |> Map.put(:progress, "0")
                  |> changeset(:create)
      refute changeset.errors[:progress]
    end
  end


  defp assert_positive_number_field(field) do
    invalids = ["not a number", "-40"]
    for value <- invalids do
      changeset = @valid_params
                  |> Map.put(field, value)
                  |> changeset(:create)
      assert changeset.errors[field],
             "`#{value}` should be invalid for #{field}"
    end

    valids = ["1", "40", "1000000", "+1"]
    for value <- valids do
      changeset = @valid_params
                  |> Map.put(field, value)
                  |> changeset(:create)
      refute changeset.errors[field],
             "`#{value}` should be valid for #{field}"
    end
  end
end
