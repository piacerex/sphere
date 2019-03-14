defmodule SphereTest do
  use ExUnit.Case
  doctest Sphere

  test "greets the world" do
    assert Sphere.hello() == :world
  end
end
