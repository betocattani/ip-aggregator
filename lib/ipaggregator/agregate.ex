defmodule Ipaggregator.Agregate do
  use GenServer

  @impl true
  def init(ip_addresses), do: {:ok, ip_addresses}

  @impl true
  def handle_call(:counter, _from, ip_addresses) do
    {:reply, __MODULE__.counter(ip_addresses), ip_addresses}
  end

  @impl true
  def handle_cast({:enqueue_ips, value}, ip_addresses) do
    {:noreply, ip_addresses ++ [value]}
  end

  def start_link(ip_addresses \\ []) do
    GenServer.start_link(__MODULE__, ip_addresses, name: __MODULE__)
  end

  def counter do
    GenServer.call(__MODULE__, :counter)
  end

  def enqueue_ips(value), do: GenServer.cast(__MODULE__, {:enqueue_ips, value})

  def counter(ip_addresses) do
    Enum.reduce(ip_addresses, %{}, &increment/2)
  end

  defp increment(ip, map) do
    Map.update(map, ip, 1, &(&1 + 1))
  end
end
