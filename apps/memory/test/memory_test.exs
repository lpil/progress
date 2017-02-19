defmodule MemoryTest do
  use ExUnit.Case, async: false
  doctest Memory
  alias Memory.Meter

  describe "create_meter/3" do
    test "successful creation" do
      name = unique_key()
      meter = %Meter{total: 50, progress: 10, unit: "megabyte", name: name}
      assert :ok == Memory.delete_meter(name)
      assert nil == Memory.get("meter_total:::" <> name)
      assert :ok == Memory.create_meter(meter)
      assert {:ok, "10"} == Memory.get("meter_progress:::" <> name)
      assert {:ok, "50"} == Memory.get("meter_total:::" <> name)
      assert {:ok, "megabyte"} == Memory.get("meter_unit:::" <> name)
    end

    test "meter already created" do
      name = unique_key()
      meter = %Meter{total: 50, progress: 10, unit: "megabyte", name: name}
      assert :ok == Memory.delete_meter(name)
      assert :ok == Memory.create_meter(meter)
      assert :already_exists == Memory.create_meter(meter)
    end
  end


  describe "delete_meter/1" do
    test "successful deletion" do
      name = unique_key()
      meter = %Meter{total: 50, progress: 10, unit: "megabyte", name: name}
      assert :ok == Memory.delete_meter(name)
      assert :ok == Memory.create_meter(meter)
      assert {:ok, "50"} == Memory.get("meter_total:::" <> name)
      assert :ok == Memory.delete_meter(name)
      assert nil == Memory.get("meter_total:::" <> name)
    end
  end


  describe "increment_meter/3" do
    test "error with unknown meter" do
      name = unique_key()
      req_id = unique_key()
      assert :ok == Memory.delete_meter(name)
      assert :unknown_meter == Memory.increment_meter(name, req_id, 50)
    end

    test "successful incrementing" do
      name = unique_key()
      req_id = unique_key()
      meter = %Meter{total: 50, progress: 10, unit: "megabyte", name: name}
      assert :ok == Memory.delete_meter(name)
      assert :ok == Memory.create_meter(meter)
      assert {:ok, 12} == Memory.increment_meter(name, req_id, 2)
    end

    test "cannot use a request id twice" do
      name = unique_key()
      req_id = unique_key()
      meter = %Meter{total: 50, progress: 10, unit: "megabyte", name: name}
      assert :ok == Memory.delete_meter(name)
      assert :ok == Memory.create_meter(meter)
      assert {:ok, 12} == Memory.increment_meter(name, req_id, 2)
      assert :repeat_request_id == Memory.increment_meter(name, req_id, 3)
    end
  end


  defp unique_key do
    System.unique_integer([:positive]) |> to_string
  end
end
