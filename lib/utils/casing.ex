defmodule PdfGenerator.Utils.Casing do
  @moduledoc """
  This module provides various helpers to handle casing
  """
  @camelize_regex ~r/(?:^|[-_])|(?=[A-Z][a-z])/

  @doc """
  Converts a string to camel case.

  ## Options
  * `:upper` - Uppercase the first letter.

  ## Examples
  iex> Casing.camelize("foo_bar")
  "fooBar"

  iex> Casing.camelize("foo_bar", :upper)
  "FooBar"
  """

  def camelize(word, option \\ :lower) do
    case Regex.split(@camelize_regex, to_string(word)) do
      words ->
        words
        |> Enum.filter(&(&1 != ""))
        |> camelize_list(option)
        |> Enum.join()
    end
  end

  defp camelize_list([], _), do: []

  defp camelize_list([h | tail], :lower) do
    [String.downcase(h)] ++ camelize_list(tail, :upper)
  end

  defp camelize_list([h | tail], :upper) do
    [String.capitalize(h)] ++ camelize_list(tail, :upper)
  end
end
