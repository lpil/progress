defmodule MemoryTest do
  use ExUnit.Case, async: false
  doctest Memory

  describe "create_meter/3" do
    test "successful creation" do
      meter = unique_key()
      assert :ok == Memory.delete_meter(meter)
      assert nil == Memory.get("meter_total:::" <> meter)
      assert :ok == Memory.create_meter(meter, 50, 10)
      assert {:ok, "10"} == Memory.get("meter_progress:::" <> meter)
      assert {:ok, "50"} == Memory.get("meter_total:::" <> meter)
    end

    test "meter already created" do
      meter = unique_key()
      assert :ok == Memory.delete_meter(meter)
      assert :ok == Memory.create_meter(meter, 50, 10)
      assert :already_exists == Memory.create_meter(meter, 40, 20)
    end
  end


  describe "delete_meter/1" do
    test "successful deletion" do
      meter = unique_key()
      assert :ok == Memory.delete_meter(meter)
      assert :ok == Memory.create_meter(meter, 50, 10)
      assert {:ok, "50"} == Memory.get("meter_total:::" <> meter)
      assert :ok == Memory.delete_meter(meter)
      assert nil == Memory.get("meter_total:::" <> meter)
    end
  end


  describe "increment_meter/3" do
    test "error with unknown meter" do
      meter = unique_key()
      req_id = unique_key()
      assert :ok == Memory.delete_meter(meter)
      assert :unknown_meter == Memory.increment_meter(req_id, meter, 50)
    end

    @tag :skip
    test "success"
    @tag :skip
    test "error with already used request id"
  end


  defp unique_key do
    System.unique_integer([:positive]) |> to_string
  end
end
