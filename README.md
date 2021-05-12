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
# Start the Gen Server
{:ok, pid} = Ipaggregator.Agregate.start_link()

# Add a new IP to the list
Ipaggregator.Agregate.add(pid, "2.2.2.2")
Ipaggregator.Agregate.add(pid, "1.2.3.4")
Ipaggregator.Agregate.add(pid, "1.2.3.4")
Ipaggregator.Agregate.add(pid, "10.1.0.38")

# View list
ip_addresses = Ipaggregator.Agregate.view(pid)

# Counter the IP's
Ipaggregator.Agregate.counter(pid, ip_addresses)

# Stop the Gen Sever
Ipaggregator.Agregate.stop(pid)
```