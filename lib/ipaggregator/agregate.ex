defmodule Ipaggregator.Agregate do
  def counter(ip_addresses) do
    Enum.reduce(ip_addresses, %{}, &increment/2)
  end

  defp increment(ip, map) do
    Map.update(map, ip, 1, &(&1 + 1))
  end
end
