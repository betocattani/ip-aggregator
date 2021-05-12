defmodule Ipaggregator.Agregate do
  @moduledoc """
  This GenServer receives a list of IP addresses and iterates over the list
  to count how many times the IP is called, an IP can be called 1 or N times.

  ## Example
      iex> ip_addresses = [
            "1.2.3.4",
            "1.2.3.4",
            "3.4.5.6",
            "10.1.0.38",
            "90.37.182.241"
          ]

      iex> {:ok, pid} = Ipaggregator.Agregate.start_link()
      {:ok, #PID<0.217.0>}

      iex> Ipaggregator.Agregate.add(pid, ip_addresses)

      iex> list = Ipaggregator.Agregate.view(pid)

      iex> Ipaggregator.Agregate.counter(pid, list)
      %{
        "1.2.3.4" => 2,
        "10.1.0.38" => 1,
        "3.4.5.6" => 1,
        "90.37.182.241" => 1
      }
  """

  use GenServer

  def start_link(ip_addresses \\ []) do
    GenServer.start_link(__MODULE__, ip_addresses, name: __MODULE__)
  end

  def counter(pid, ip_addresses) do
    GenServer.call(pid, {:counter, ip_addresses})
  end

  def view(pid) do
    GenServer.call(pid, :view)
  end

  def add(pid, ip_address) do
    GenServer.cast(pid, ip_address)
  end

  def stop(pid) do
    GenServer.stop(pid, :normal, :infinity)
  end

  def init(list) do
    {:ok, list}
  end

  def handle_cast(new_list, ip_addresses) do
    updated_list = ip_addresses ++ new_list
    {:noreply, updated_list}
  end

  def handle_call(:view, _from, ip_addresses) do
    {:reply, ip_addresses, ip_addresses}
  end

  def handle_call({:counter, ip_addresses}, _from, ip_addresses) do
    ips_processed = __MODULE__.check_duplication(ip_addresses)
    {:reply, ips_processed, ip_addresses}
  end

  def terminate(_reason, ip_addresses) do
    IO.puts("Terminating verification")
    IO.inspect(ip_addresses)
    :ok
  end

  @doc """
  This function is responsible to iterave over the list and count
  how many times the IP is called.

  ## Examples
      iex> ip_addresses = [
        "1.2.3.4",
        "1.2.3.4",
        "3.4.5.6",
        "10.1.0.38",
        "90.37.182.241"
      ]

      iex> Ipaggregator.Agregate.check_duplication(ip_addresses)
      %{
        "1.2.3.4" => 2,
        "10.1.0.38" => 1,
        "3.4.5.6" => 1,
        "90.37.182.241" => 1
      }
  """
  def check_duplication(ip_addresses) do
    Enum.reduce(ip_addresses, %{}, &increment/2)
  end

  defp increment(ip, map) do
    Map.update(map, ip, 1, &(&1 + 1))
  end
end
