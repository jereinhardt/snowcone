# Snowcone

Elixir API wrapper for the <a href="https://frost.po.et/">Frost API</a>.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `snowcone` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:snowcone, "~> 0.1.0"}
  ]
end
```

## Usage

To best utilize snowcone, you will want to create a module in your application to handle api requests. Use `Snowcone` when defining the module, and include your Frost API key.

```elixir
defmodule MyApp.FrostAPI do
  use Snowcone, frost_key: "secret frost api key"
end
```

You can use this module as your primary wrapper for interacting with the Frost API.  This makes the following methods available:

```elixir

# Retrieve a list of all available works.

MyApp.FrostAPI.get_works
# ** {:ok, [%Frost.Work{...}]}


# Retrieve a work based on its id.

MyApp.FrostAPI.get_work("work_id")
# ** {:ok, %Frost.Work{...}}


# Create a work.  Returns a map with the work id.

MyApp.FrostAPI.create_work(work_params)
# ** {:ok, %{work_id: "work_id"}}


# Any API request that fails will return a tuple with the error message.

MyApp.FrostAPI.get_work("bad_work_id")
# ** {:error, "The server encountered an internal error. Please retry the request."}
```