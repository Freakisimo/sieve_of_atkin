defmodule SieveOfAtkin do
  @moduledoc """
  Documentation for `SieveOfAtkin`.
  """

  @doc """
  Generates prime numbers up to a given maximum.

  ## Examples

      iex> SieveOfAtkin.generate_primes(30) |> Enum.sort()
      [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
  """
  def generate_primes(n)

  def generate_primes(n) when n < 0 do
    raise "Can't compute negative primes"
  end

  def generate_primes(n) when n <= 1, do: []
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
        |> Flow.from_enumerable()
        |> Flow.map(fn {x, y} ->
          (4 * x * x) + (y * y)
        end)
        |> Flow.filter(fn n ->
          (n <= max_value) and (Integer.mod(n, 12) == 1 or Integer.mod(n, 12) == 5)
        end)
        |> Flow.partition()
        |> Flow.reduce(fn -> %{} end, fn key, acc ->
          case acc do
            %{^key => value} -> %{acc | key => value + 1}
            %{} -> Map.put(acc, key, 1)
          end
        end)
        |> Flow.filter(fn {_n, freq} ->
          Integer.mod(freq, 2) == 1
        end)
        |> Flow.map(fn {n, _freq} ->
          n
        end)
        |> Enum.to_list()
      end)

    second_possible_primes =
      Task.async(fn ->
        xy_pairs
        |> Flow.from_enumerable()
        |> Flow.map(fn {x, y} ->
          (3 * x * x) + (y * y)
        end)
        |> Flow.filter(fn n ->
          (n <= max_value) and (Integer.mod(n, 12) == 7)
        end)
        |> Flow.partition()
        |> Flow.reduce(fn -> %{} end, fn key, acc ->
          case acc do
            %{^key => value} -> %{acc | key => value + 1}
            %{} -> Map.put(acc, key, 1)
          end
        end)
        |> Flow.filter(fn {_n, freq} ->
          Integer.mod(freq, 2) == 1
        end)
        |> Flow.map(fn {n, _freq} ->
          n
        end)
        |> Enum.to_list()
      end)

    third_possible_primes =
      Task.async(fn ->
        xy_pairs
        |> Flow.from_enumerable()
        |> Flow.filter(fn {x, y} -> x > y end)
        |> Flow.map(fn {x, y} ->
          (3 * x * x) - (y * y)
        end)
        |> Flow.filter(fn n ->
          (n <= max_value) and (Integer.mod(n, 12) == 11)
        end)
        |> Flow.partition()
        |> Flow.reduce(fn -> %{} end, fn key, acc ->
          case acc do
            %{^key => value} -> %{acc | key => value + 1}
            %{} -> Map.put(acc, key, 1)
          end
        end)
        |> Flow.filter(fn {_n, freq} ->
          Integer.mod(freq, 2) == 1
        end)
        |> Flow.map(fn {n, _freq} ->
          n
        end)
        |> Enum.to_list()
      end)

    possible_primes =
      Task.await(first_possible_primes, :infinity)
      |> Stream.concat(Task.await(second_possible_primes, :infinity))
      |> Stream.concat(Task.await(third_possible_primes, :infinity))

    non_primes =
      possible_primes
      |> Flow.from_enumerable()
      |> Flow.flat_map(fn n ->
        sq = n * n

        Stream.iterate(1, &(&1 + 1))
        |> Stream.map(&(&1 * sq))
        |> Stream.take_while(&(&1 <= max_value))
      end)
      |> Flow.uniq()
      |> MapSet.new()

    possible_primes
    |> Stream.reject(fn n ->
      MapSet.member?(non_primes, n)
    end)
    |> Stream.concat([2, 3])
    |> Enum.to_list()
  end
end
