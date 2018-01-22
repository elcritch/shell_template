defmodule ShellTemplateTest do
  use ExUnit.Case
  doctest ShellTemplate

  test "greets the world" do
    assert ShellTemplate.hello() == :world
  end
end
