defmodule Ipaggregator do
  def start do
    Ipaggregator.Agregate.start_link()
  end

  def add(pid, ip_addresses) do
    GenServer.cast(pid, ip_addresses)
  end

  @doc """
  This function is responsible to iterate over the list and count
  how many times the IP is called.

  # ## Examples
  #     iex> ip_addresses = [
  #       "1.2.3.4",
  #       "1.2.3.4",
  #       "3.4.5.6",
  #       "10.1.0.38",
  #       "90.37.182.241"
  #     ]

  #     iex> Ipaggregator.counter(pid, ip_addresses)
  #     %{
  #       "1.2.3.4" => 2,
  #       "10.1.0.38" => 1,
  #       "3.4.5.6" => 1,
  #       "90.37.182.241" => 1
  #     }
  """
  def counter(pid, ip_addresses) do
    GenServer.call(pid, {:counter, ip_addresses})
  end

  def view(pid) do
    GenServer.call(pid, :view)
  end

  def stop(pid) do
    GenServer.stop(pid, :normal, :infinity)
  end
end
