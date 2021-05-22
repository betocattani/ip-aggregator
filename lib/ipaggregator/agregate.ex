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
    ips_processed = Enum.frequencies(ip_addresses)
    {:reply, ips_processed, ip_addresses}
  end

  def terminate(_reason, ip_addresses) do
    IO.puts("Terminating verification")
    IO.inspect(ip_addresses)
    :ok
  end
end
