# Snowcone

Elixir API wrapper for the <a href="https://frost.po.et/">Frost API</a>.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `snowcone` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:snowcone, "~> 0.1.2"}
  ]
end
```

## Configuration

You'll need to configure your api token and the service url you would like to use.

```elixir
# config/config.exs

use Mix.Config

config :snowcone,
  service_url: "https://api.poetnetwork.net",
  api_token: "your api token"
```

## Usage

The `Snowcone` modules allows you to interact Frost enpoints related to works.

- `get_works/0` - retrieves all works related to an account
- `get_work/1` - retrieves a single work related to an account
- `create_work/1` - create a work for an account

```elixir

# Retrieve a list of all available works.

Snowcone.get_works
# ** {:ok, [%Frost.Work{...}]}


# Retrieve a work based on its id.

Snowcone.get_work("work_id")
# ** {:ok, %Frost.Work{...}}


# Create a work.  Returns a map with the work id.

Snowcone.create_work(work_params)
# ** {:ok, %{work_id: "work_id"}}


# Any API request that fails will return a tuple with the error message.

Snowcone.get_work("invalid_work_id")
# ** {:error, "Work not found."}
```