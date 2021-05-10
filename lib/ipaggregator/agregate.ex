defmodule Ipaggregator.Agregate do
  def counter(ip_addresses) do
    Enum.reduce(ip_addresses, %{}, fn ip, acc ->
      count = acc[ip] || 0
      Map.put(acc, ip, count + 1)
    end)
  end
end
