defmodule ShellTemplate do
  @moduledoc """
  Documentation for ShellTemplate.
  """

  @bracket_regex ~r/(?!\\) \${ (\w+) }/x
  @single_regex ~r/(?!\\) \$ (\w+) /x

  @doc """

      iex> ShellTemplate.format("test ${TEST}!", %{TEST: "hello world"})
      "hello world!"

  """
  def format(template, values) when is_map(values) do
    result = ""
    IO.puts "results: #{inspect result}"
    ""
  end

end

defmodule TestGrammar do
  use Neotomex.ExGrammar

  @root true
  define :top, "elem+" do
    all ->
      IO.puts "top: #{inspect all}"
      all
  end

  define :elem, "space? (var / number) space?" do
    all ->
      IO.puts "elem: #{inspect all}"
      "elem:"<>inspect(all)
  end

  define :var, "dollar word (word* digit)*" do
    all ->
      IO.puts "var: #{inspect all}"
      "var:"<>inspect(all)
  end

  define :number, "digit+" do
    digits ->
      IO.puts "number: #{inspect digits}"
      digits |> Enum.join |> String.to_integer
  end

  define :dollar, "[$]"
  #define :word, "[A-Za-z]"
  define :word, "[A-Za-z]"
  define :digit, "[0-9]"

  define :space, "[ \\r\\n\\s\\t]"
end

