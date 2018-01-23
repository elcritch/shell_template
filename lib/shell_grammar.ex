

defmodule ShellTemplate.Grammar do
  use Neotomex.ExGrammar

  @root true
  define :top, "elem+" do
    all ->
      # IO.puts "top: #{inspect all}"
      all |> List.flatten()
  end

  define :elem, "space? ( dollar_esc / simple_var / bracket_var / plaintext) space?" do
    all ->
      IO.puts "elem: #{inspect all}"
      all |> List.flatten() |> Enum.reject(&(&1 == nil))
  end

  define :simple_var, "<'$'> word" do
    var ->
      {:var, to_string(var), []}
  end

  define :bracket_var, "<'${'> word var_opts? <'}'>" do
    [var, nil] ->
      {:var, to_string(var), [bracket: true]}
    [var, extras] = all ->
      IO.puts "bracket_var:extra: #{inspect all}"
      {:var, to_string(var), [bracket: true, extras: extras]}
    other ->
      IO.puts "bracket_var:other: #{inspect other}"
      other
  end

  define :var_opts, "<':-'> ( (<!'}'> .)*)" do
    all ->
      # IO.puts "var_opts: #{inspect all}"
      {:default, all |> to_string()}
  end


  define :dollar_esc, "'$$'" do
    _val ->
      {:text, "$", []}
  end

  define :plaintext, "(<!'$'> .)+" do
    other ->
      {:text, to_string(other), []}
  end

  define :space, "[ \\r\\n\\s\\t]" do
    spc ->
      {:text, to_string(spc), []}
  end

  define :dollar, "[$]"
  define :word, "[A-Za-z0-9_]+"
  define :letter, "[A-Za-z]"
end
