defmodule Memory.Application do
  @moduledoc false

  use Application
  alias Memory.RedisRepo

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Memory.Pool, [])]

    opts = [strategy: :one_for_one, name: Memory.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
