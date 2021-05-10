defmodule IpaggregatorTest do
  use ExUnit.Case
  doctest Ipaggregator

  test "returns a map of ip_addresses formated with the counter of each ip" do
    ip_addresses = [
      "1.2.3.4",
      "3.4.5.6",
      "10.1.0.38",
      "90.37.182.241",
      "10.12.15.0",
      "90.37.182.241",
      "172.10.11.15",
      "111.111.17.35",
      "3.4.5.6",
      "172.16.28.99"
    ]

    expected_output = %{
      "1.2.3.4" => 1,
      "10.1.0.38" => 1,
      "10.12.15.0" => 1,
      "111.111.17.35" => 1,
      "172.10.11.15" => 1,
      "172.16.28.99" => 1,
      "3.4.5.6" => 2,
      "90.37.182.241" => 2
    }

    assert Ipaggregator.Agregate.check_duplication(ip_addresses) == expected_output
  end

  test "returns a empty map when ip_addresses list is empty" do
    assert Ipaggregator.Agregate.check_duplication([]) == %{}
  end
end
