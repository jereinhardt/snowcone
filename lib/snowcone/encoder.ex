defmodule Snowcone.Encoder do
  @moduledoc false

  import String, only: [first: 1, upcase: 1, downcase: 1]

  @doc false
  def camelize_keys(map) do
    for {k, v} <- map, into: %{}, do: {camelize(k), v}
  end

  @doc false
  def snake_case_keys(map) do
    for {k, v} <- map, into: %{}, do: {snake_case(k), v}
  end

  defp camelize(val) when is_atom(val) do
    val
    |> Atom.to_string()
    |> camelize()
  end

  defp camelize(val) when is_binary(val) do
    first_char = first(val)
    val
    |> Macro.camelize()
    |> String.replace(~r/^#{upcase(first_char)}/, downcase(first_char))
    |> String.to_atom()
  end

  defp snake_case(val) when is_atom(val) do
    val
    |> Atom.to_string()
    |> snake_case()
  end

  defp snake_case(val) when is_binary(val) do
    val
    |> Macro.underscore()
    |> String.to_atom()
  end
end