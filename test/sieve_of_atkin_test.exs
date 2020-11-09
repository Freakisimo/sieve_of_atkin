defmodule SieveOfAtkinTest do
  use ExUnit.Case
  doctest SieveOfAtkin

  test "generates primes" do
    assert SieveOfAtkin.generate_primes(30) |> Enum.sort() == [
      2, 3, 5, 7, 11, 13, 17, 19, 23, 29
    ]
  end
end
