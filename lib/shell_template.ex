defmodule ShellTemplate do
  @moduledoc """
  Documentation for ShellTemplate.
  """


  @doc """

      iex> ShellTemplate.format("test: ${TEST}!", %{TEST: "hello world"})
      "test: hello world!"

  """
  def format(template, values, opts \\ []) when is_map(values) do
    results = ShellTemplate.Grammar.parse!(template)

    keyfn =
      if opts[:upcase] == true do
        &String.upcase(to_string(&1))
      else
        &to_string/1
      end

    values = Enum.map(values, fn {k,v} -> {keyfn.(k), v} end) |> Map.new

    Enum.map(results, &handle(&1, values)) |> to_string()
  end

  defp handle({:text, text, opts}, _values) do
    text
  end

  defp handle({:var, varname, opts}, values) when is_map(values) do

    case Keyword.get(opts, :default) do
      nil ->
        Map.fetch!(values, varname)
      default when is_binary(default) ->
        Map.get(values, varname, default)
      {:var, def_varname, _} ->
        Map.get_lazy(values, varname, fn -> Map.get(values, def_varname) end)
    end
  end


end
