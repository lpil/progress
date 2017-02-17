defmodule Memory do
  @moduledoc """
  The Memory application provides a persistance layer
  backed by Redis.

  The data stored may be forgotten at a later date.
  """

  @doc """
  Write a value to the store.

  """
  def put(key, value) when is_binary(key) do
    case redis_send(["SET", key, value]) do
      "OK" -> :ok
    end
  end

  @doc """
  Read a value from the store.

  """
  def get(key) when is_binary(key) do
    case redis_send(["GET", key]) do
      :undefined -> nil
      value -> {:ok, value}
    end
  end


  @doc """
  Delete a value from the store.

  """
  def delete(key) when is_binary(key) do
    case redis_send(["DEL", key]) do
      _ -> :ok
    end
  end


  #
  # Private
  #

  defp redis_send(query) do
    Exredis.query(Memory.RedisRepo, query)
  end
end
