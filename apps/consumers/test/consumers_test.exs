defmodule ConsumersTest do
  use ExUnit.Case
  doctest Consumers

  test "greets the world" do
    assert Consumers.hello() == :world
  end
end
