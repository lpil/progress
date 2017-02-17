defmodule MemoryTest do
  use ExUnit.Case, async: false
  doctest Memory

  test "values can be put'd, delete'd and get'd" do
    key = System.unique_integer([:positive]) |> to_string
    assert {:ok, _} = Memory.delete(key)
    assert :ok == Memory.put(key, "some-value")
    assert {:ok, "some-value"} == Memory.get(key)
    assert {:ok, _} = Memory.delete(key)
    assert nil == Memory.get(key)
  end
end
