defmodule MetexOtp.Cache do
  use GenServer
  @name CACHE

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def write(key, term) do
    GenServer.cast(@name, {:write, {key, term}})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  ## Server callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:write, {key, term}}, _from, state) do
    {:reply, {key, term}, state}
  end

  def handle_call({:read, key, _from, state}) do
    {:reply, state[key], state}
  end

  ## Helper functions
end
