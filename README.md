# Ipaggregator

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ipaggregator` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ipaggregator, "~> 0.1.0"}
  ]
end
```

Exercise
```elixir
ip_addresses = [
  "1.2.3.4",
  "1.2.3.4",
  "3.4.5.6",
  "10.1.0.38",
  "90.37.182.241"
]

{:ok, pid} = GenServer.start_link(Ipaggregator.Agregate, ip_addresses)

GenServer.call(pid, :counter)

GenServer.cast(pid, {:enqueue_ip, "2.2.2.2"})
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ipaggregator](https://hexdocs.pm/ipaggregator).

