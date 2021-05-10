defmodule Ipaggregator.Agregate do
  use GenServer

  def start_link(ip_addresses \\ []) do
    GenServer.start_link(__MODULE__, ip_addresses, name: __MODULE__)
  end

  def counter(server_pid, ip_addresses) do
    GenServer.call(server_pid, {:counter, ip_addresses})
  end

  def enqueue_ip(value) do
    GenServer.cast(__MODULE__, {:enqueue_ip, value})
  end

  @impl true
  def init(ip_addresses), do: {:ok, ip_addresses}

  @impl true
  def handle_call(:counter, _from, ip_addresses) do
    {:reply, __MODULE__.check_duplication(ip_addresses), ip_addresses}
  end

  @impl true
  def handle_cast({:enqueue_ip, value}, ip_addresses) do
    {:noreply, ip_addresses ++ [value]}
  end

  def check_duplication(ip_addresses) do
    Enum.reduce(ip_addresses, %{}, &increment/2)
  end

  defp increment(ip, map) do
    Map.update(map, ip, 1, &(&1 + 1))
  end
end
