defmodule Memory.Store do
  @moduledoc """
  A process that holds onto the data for one in progress item.
  """

  defstruct total: 100,
            progress: 0

  #
  # Public API
  #

  @doc """
  Arguments:

  - `:total` Maximum value of progress.
  """
  def start_link(args) when is_list(args) do
    case Keyword.fetch(args, :total) do

      {:ok, total} when is_integer(total) and total > 0 ->
        data = %__MODULE__{total: total}
        Agent.start_link(fn -> data end)

      :error ->
        :total_required
    end
  end

  @doc """
  Query the store for the current data
  """
  def info(store) when is_pid(store) do
    Agent.get(store, fn data -> data end)
  end

  @doc """
  Update the progress of the store.

  Truncates progress if over total.
  """
  def update(store, progress)
    when is_pid(store) and is_integer(progress) and progress > 0
  do
    result = Agent.get_and_update(store, fn data ->
      capped_progress = min(progress, data.total)
      new_data = %{data | progress: capped_progress}
      {new_data, new_data}
    end)
    {:ok, result}
  end
end
