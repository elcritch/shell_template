defmodule ShellTemplate do
  @moduledoc """
  Documentation for ShellTemplate.
  """


  @doc """

      iex> ShellTemplate.format("test: ${TEST}!", %{TEST: "hello world"})
      "test: hello world!"

  """
  def format(template, values) when is_map(values) do
    results = ShellTemplate.Grammar.parse!(template)
    # IO.puts "\n\nresults: #{inspect results} -- #{inspect template}"
    # {:ok, results} = results
    values = Enum.map(values, fn {k,v} -> {to_string(k), v} end) |> Map.new

    Enum.map(results, &handle(&1, values)) |> to_string()
  end

  defp handle({:text, text, opts}, _values) do
    text
  end

  defp handle({:var, varname, opts}, values) when is_map(values) do

    case Keyword.get(opts, :default) do
      nil ->
        Map.fetch!(values, varname)
      default ->
        Map.get(values, varname, default)
    end
  end


end
