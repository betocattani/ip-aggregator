defmodule IpaggregatorTest do
  use ExUnit.Case, async: true
  doctest Ipaggregator

  test "start process" do
    {:ok, pid} = Ipaggregator.Agregate.start_link()
    assert Process.alive?(pid) == true
  end

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

    {:ok, pid} = Ipaggregator.Agregate.start_link()
    Ipaggregator.Agregate.add(pid, ip_addresses)
    list = Ipaggregator.Agregate.view(pid)

    assert Ipaggregator.Agregate.counter(pid, list) == expected_output
  end

  test "view the IP's added in the GenServer state" do
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

    {:ok, pid} = Ipaggregator.Agregate.start_link()
    Ipaggregator.Agregate.add(pid, ip_addresses)

    assert Ipaggregator.Agregate.view(pid) === ip_addresses
  end

  test "add a new list of IP's in the state of the GenServer" do
    ip_addresses = [
      "1.2.3.4",
      "3.4.5.6"
    ]

    expected_output = %{
      "1.2.3.4" => 1,
      "3.4.5.6" => 1,
      "22.22.22.22" => 1
    }

    {:ok, pid} = Ipaggregator.Agregate.start_link()

    Ipaggregator.Agregate.add(pid, ip_addresses)
    Ipaggregator.Agregate.add(pid, ["22.22.22.22"])

    list = Ipaggregator.Agregate.view(pid)

    assert Ipaggregator.Agregate.counter(pid, list) == expected_output
  end

  test "returns a empty map when ip_addresses list is empty" do
    {:ok, pid} = Ipaggregator.Agregate.start_link()

    assert Ipaggregator.Agregate.counter(pid, []) == %{}
  end
end
