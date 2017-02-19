defmodule Memory.Meter do

  @enforce_keys [:name, :total, :unit]
  defstruct name: nil,
            total: nil,
            unit: nil,
            progress: 0
end
