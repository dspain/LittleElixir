defmodule MetexOtp.Cache do
  use GenServer
  @name CACHE

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: @name])
  end

  def write(key, term) do
    GenServer.cast(@name, {:write, {key, term}})
  end

  def read(key) do
    GenServer.call(@name, {:read, key})
  end

  def delete(key) do
    GenServer.cast(@name, {:delete, key})
  end

  def clear do
    GenServer.cast(@name, :clear)
  end

  def exist?(key) do
    GenServer.call(@name, {:exist?, key})
  end

  ## Server callbacks
  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:write, {key, term}}, state) do
    {:noreply, Map.put(state, key, term)}
  end

  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end

  def handle_cast(:clear, _state) do
    {:noreply, %{}}
  end

  def handle_call({:read, key}, _from, state) do
    {:reply, state[key], state}
  end

  def handle_call({:exist?, key}, _from, state) do
    {:reply, Map.has_key?(state, key), state}
  end

  ## Helper functions
end
