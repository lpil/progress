defmodule Memory.StoreTest do
  use ExUnit.Case, async: true
  doctest Memory.Store
  alias Memory.Store


  describe "start_link/1 and info/1" do
    test "errors when missing total" do
      assert :total_required = Store.start_link([])
    end

    test "starting values" do
      assert {:ok, store} = Store.start_link(total: 2000)
      info = Store.info(store)
      assert info.total == 2000
      assert info.progress == 0
    end
  end


  describe "update/2" do
    test "progress is set" do
      assert {:ok, store} = Store.start_link(total: 500)
      info = Store.info(store)
      assert info.total == 500
      assert info.progress == 0

      # Check returned data
      assert {:ok, result} = Store.update(store, 30)
      assert result.total == 500
      assert result.progress == 30

      # Check persisted data is the same
      assert result == Store.info(store)
    end

    test "progress cannot exceed total" do
      assert {:ok, store} = Store.start_link(total: 100)
      assert {:ok, result} = Store.update(store, 101)
      assert result.total == 100
      assert result.progress == 100
    end
  end
end
