defmodule MetexOtp.Cache do
  use GenServer
  @name CACHE

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def write(key, term) do
    GenServer.call(@name, {:write, {key, term}})
  end

  ## Server callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:write, {key, term}}, _from, state) do
    {:reply, {key, term}, state}
  end

  ## Helper functions
end
