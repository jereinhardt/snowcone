defmodule Snowcone.MixProject do
  use Mix.Project

  @project_url "https://github.com/jereinhardt/snowcone"

  def project do
    [
      app: :snowcone,
      version: "0.1.2",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package(),
      name: "Snowcone",
      source_url: @project_url,
      homepage_url: @project_url
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.14", only: :dev},
      {:httpoison, "~> 1.0"},
      {:poison, "~> 3.1"}
    ]
  end

  defp package do
    [
      maintainers: ["Josh Reinhardt"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url}
    ]
  end

  def description do
    "An Elixir API wrapper for the Frost API."
  end
end
