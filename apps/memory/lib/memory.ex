defmodule Memory do
  @moduledoc """
  The Memory application provides a persistance layer
  backed by Redis.

  The data stored may be forgotten at a later date.
  """

  alias Memory.Pool

  @doc """
  Write a value to the store.

  """
  def put(key, value) when is_binary(key) do
    case Pool.command(["SET", key, value]) do
      {:ok, "OK"} -> :ok
    end
  end


  @doc """
  Read a value from the store.

  """
  def get(key) when is_binary(key) do
    case Pool.command(["GET", key]) do
      {:ok, nil} -> nil
      {:ok, value} -> {:ok, value}
    end
  end


  @doc """
  Delete a value from the store.

  """
  def delete(key) when is_binary(key) do
    Pool.command(["DEL", key])
  end
end
