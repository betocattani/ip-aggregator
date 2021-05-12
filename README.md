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
{:ok, pid} = Ipaggregator.Agregate.start_link()
# {:ok, #PID<0.209.0>}

ip_addresses = [
  "2.2.2.2",
  "1.2.3.4",
  "1.2.3.4",
  "10.1.0.38"
]
# ["2.2.2.2", "1.2.3.4", "1.2.3.4", "10.1.0.38"]

# Add a new IP to the list
Ipaggregator.Agregate.add(pid, ip_addresses)
# :ok

# View list
list = Ipaggregator.Agregate.view(pid)
# ["2.2.2.2", "1.2.3.4", "1.2.3.4", "10.1.0.38"]

# Counter the IP's
Ipaggregator.Agregate.counter(pid, list)
# %{"1.2.3.4" => 2, "10.1.0.38" => 1, "2.2.2.2" => 1}

# Stop the Gen Sever
Ipaggregator.Agregate.stop(pid)
# Terminating verification
# ["2.2.2.2", "1.2.3.4", "1.2.3.4", "10.1.0.38"]
# :ok
```