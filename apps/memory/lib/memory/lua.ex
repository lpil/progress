defmodule Memory.Lua do
  @moduledoc """
  Exposing Lua scripts in `priv` as macros.
  """

  scripts =
    :memory
    |> :code.priv_dir()
    |> Path.join("*.lua")
    |> Path.wildcard()

  for script <- scripts do
    name =
      script
      |> Path.basename(".lua")
      |> String.to_atom()

    source =
      File.read!(script)

    @external_resource script

    defmacro unquote(name)() do
      unquote(source)
    end
  end
end
