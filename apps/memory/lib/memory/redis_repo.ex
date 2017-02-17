defmodule Memory.RedisRepo do
  @moduledoc """
  Repository through which the Memory application connects
  to the Redis database.
  """

  def start_link(name) do
    client = Exredis.start_using_connection_string(redis_uri())
    true = Process.register(client, name)
    {:ok, client}
  end

  defp redis_uri do
    System.get_env("REDIS_URI") || "redis://localhost:6379/0"
  end
end
