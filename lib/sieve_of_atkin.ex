defmodule SieveOfAtkin do
  @moduledoc """
  Documentation for `SieveOfAtkin`.
  """

  def generate_primes(n) when n < 0 do
    raise "Can't compute negative primes"
  end

  def generate_primes(n) when n <= 2, do: [2]
  def generate_primes(n) when n <= 3, do: [2, 3]
  def generate_primes(n) when n <= 5, do: [2, 3, 5]

  def generate_primes(max_value) do
    max_power = floor(:math.sqrt(max_value))

    xy_pairs =
      1..max_power
      |> Stream.flat_map(fn x ->
        Stream.map(1..max_power, fn y ->
          {x, y}
        end)
      end)

    first_possible_primes =
      Task.async(fn ->
        xy_pairs
        |> Stream.map(fn {x, y} ->
          (4 * x * x) + (y * y)
        end)
        |> Stream.filter(fn n ->
          (n <= max_value) and (Integer.mod(n, 12) == 1 or Integer.mod(n, 12) == 5)
        end)
        |> Enum.frequencies()
        |> Enum.filter(fn {_n, freq} ->
          Integer.mod(freq, 2) == 1
        end)
        |> Map.new()
        |> Map.keys()
      end)

    second_possible_primes =
      Task.async(fn ->
        xy_pairs
        |> Stream.map(fn {x, y} ->
          (3 * x * x) + (y * y)
        end)
        |> Stream.filter(fn n ->
          (n <= max_value) and (Integer.mod(n, 12) == 7)
        end)
        |> Enum.frequencies()
        |> Enum.filter(fn {_n, freq} ->
          Integer.mod(freq, 2) == 1
        end)
        |> Map.new()
        |> Map.keys()
      end)

    third_possible_primes =
      Task.async(fn ->
        xy_pairs
        |> Stream.filter(fn {x, y} -> x > y end)
        |> Stream.map(fn {x, y} ->
          (3 * x * x) - (y * y)
        end)
        |> Stream.filter(fn n ->
          (n <= max_value) and (Integer.mod(n, 12) == 11)
        end)
        |> Enum.frequencies()
        |> Enum.filter(fn {_n, freq} ->
          Integer.mod(freq, 2) == 1
        end)
        |> Map.new()
        |> Map.keys()
      end)

    possible_primes =
      Task.await(first_possible_primes, :infinity)
      |> Stream.concat(Task.await(second_possible_primes, :infinity))
      |> Stream.concat(Task.await(third_possible_primes, :infinity))

    non_primes =
      possible_primes
      |> Stream.flat_map(fn n ->
        sq = n * n

        Stream.iterate(1, &(&1 + 1))
        |> Stream.map(&(&1 * sq))
        |> Stream.take_while(&(&1 <= max_value))
      end)
      |> Stream.uniq()
      |> MapSet.new()

    possible_primes
    |> Stream.reject(fn n ->
      MapSet.member?(non_primes, n)
    end)
    |> Stream.concat([2, 3])
    |> Enum.to_list()
  end
end
