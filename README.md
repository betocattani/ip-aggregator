# Ipaggregator

Elixir Gen server example to count how many times the IP is called inside a list

## Installation
```elixir
$ git clone project
$ cd project
$ mix deps.get
```

Running the code
```elixir
# Start a new iex session
$ iex -S mix

# Start the Gen Server
{:ok, pid} = Ipaggregator.start()
# {:ok, #PID<0.209.0>}

# list of IP addresses
ip_addresses = [
  "2.2.2.2",
  "1.2.3.4",
  "1.2.3.4",
  "10.1.0.38"
]

Ipaggregator.add(pid, ip_addresses)
=> ["2.2.2.2", "1.2.3.4", "1.2.3.4", "10.1.0.38"]

# Add a new IP to the list
Ipaggregator.add(pid, ip_addresses)
# :ok

# View list
list = Ipaggregator.view(pid)
# ["2.2.2.2", "1.2.3.4", "1.2.3.4", "10.1.0.38"]

# Counter the IP's
Ipaggregator.counter(pid, list)
# %{"1.2.3.4" => 2, "10.1.0.38" => 1, "2.2.2.2" => 1}

# Stop the Gen Sever
Ipaggregator.stop(pid)
# Terminating verification
# ["2.2.2.2", "1.2.3.4", "1.2.3.4", "10.1.0.38"]
# :ok
```