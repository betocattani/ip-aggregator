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

      iex> {:ok, pid} = GenServer.start_link(Ipaggregator.Agregate, ip_addresses)
      {:ok, #PID<0.217.0>}

      iex> GenServer.call(pid, :counter)
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
