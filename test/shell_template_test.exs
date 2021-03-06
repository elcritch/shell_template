defmodule ShellTemplateTest do
  use ExUnit.Case
  doctest ShellTemplate

  test "greets the world" do
    result = ShellTemplate.format("test: ${TEST}!", %{TEST: "hello world"})
    assert result == "test: hello world!"
  end

  test "greets the world default" do
    result = ShellTemplate.format("test: ${TEST:-anybody_out_there}?", %{TEST1: "hello world"})
    assert result == "test: anybody_out_there?"
  end

  test "greets the world default and var?" do
    result = ShellTemplate.format("test: ${TEST:-$TEST1}?", %{TEST1: "hello world"})
    assert result == "test: hello world?"
  end

  test "uppercase map keywords?" do
    result = ShellTemplate.format("test: ${TEST}.", %{test: "hello world"}, upcase: true)
    assert result == "test: hello world."
  end

  test "iolist output " do
    result = ShellTemplate.format("test: ${test};", %{test: "hello world"}, iolist: true)
    assert result == ["test: ", "hello world", ";"]
  end
end
