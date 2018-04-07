defmodule Snowcone.MixProject do
  use Mix.Project

  def project do
    [
      app: :snowcone,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      name: "Snowcone",
      source_url: "https://github.com/jereinhardt/snowcone"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"}
    ]
  end

  def description do
    "An Elixir API wrapper for the Frost API."
  end
end
