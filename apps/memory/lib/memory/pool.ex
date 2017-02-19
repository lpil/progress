defmodule Memory.Pool do
  use Supervisor

  @moduledoc """
  A pool of workers that handle Redis connections.
  Includes a Supervisor and helper functions.
  """

  @pool_size 5

  @doc """
  Execute a Redis command using a worker from the pool.

  """
  def command(command) do
    Redix.command(random_worker(), command)
  end

  @doc """
  Execute a Redis pipeline using a worker from the pool.

  """
  def pipeline(pipeline) do
    Redix.pipeline(random_worker(), pipeline)
  end


  #
  # OTP callbacks
  #

  def start_link do
    Supervisor.start_link(__MODULE__, :no_args)
  end

  def init(:no_args) do
    uri = redis_uri()
    children =
      for i <- 0..(@pool_size - 1) do
        worker(Redix, [uri, [name: worker_name(i)]], id: {Redix, i})
      end
    supervise(children, strategy: :one_for_one)
  end


  #
  # Private
  #

  defp worker_name(i) when is_integer(i) do
    :"redix_#{i}"
  end

  defp random_worker do
    System.unique_integer([:positive])
    |> rem(@pool_size)
    |> worker_name()
  end

  defp redis_uri do
    System.get_env("REDIS_URI") || "redis://localhost:6379/0"
  end
end
