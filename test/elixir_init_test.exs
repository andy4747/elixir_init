defmodule ElixirInitTest do
  use ExUnit.Case
  doctest ElixirInit

  test "greets the world" do
    assert ElixirInit.hello() == :world
  end
end
