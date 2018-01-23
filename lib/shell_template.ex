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

defmodule ShellVarGrammar do
  use Neotomex.ExGrammar

  @root true
  define :top, "elem+" do
    all ->
      IO.puts "top: #{inspect all}"
      all |> List.flatten()
  end

  define :elem, "<space?> ( dollar_esc / simple_var / bracket_var / plaintext) <space?>" do
    all ->
      IO.puts "all: #{inspect all}"
      all |> List.flatten()
  end

  define :simple_var, "<'$'> word" do
    var ->
      {:var, to_string(var), []}
  end

  define :bracket_var, "<'${'> word <'}'>" do
    var ->
      {:var, to_string(var), :bracket}
  end

  define :dollar_esc, "'$$'" do
    _val ->
      {:text, "$", :escaped}
  end

  define :plaintext, "(<!'$'> .)+" do
    other ->
      {:text, to_string(other)}
  end

  define :dollar, "[$]"
  define :word, "[A-Za-z0-9_]+"
  define :letter, "[A-Za-z]"
  define :space, "[ \\r\\n\\s\\t]"
end
