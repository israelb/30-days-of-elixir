defmodule Fib do
  @moduledoc """
    Lazy Fibonacci Sequence
  """

  defrecord FibVal, val: 0, next: 1

  @doc """
    Return a lazy sequence of FibVals.

    To get the values, use map &(&1.val)

      iex> Fib.fib |> Stream.map(&(&1.val)) |> Enum.take(10)
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  """
  def fib do
    Stream.iterate FibVal.new, fn FibVal[val: val, next: next] ->
      FibVal.new(val: next, next: val + next)
    end
  end

  @doc """
    Return a lazy sequence of Fibonacci numbers

    This one is better as it returns the actual integer value
    and doesn't use FibVal, thanks to Stream.unfold/2

      iex> Fib.fib2 |> Enum.take(10)
      [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
  """
  def fib2 do
    Stream.unfold({0, 1}, fn {a, b} -> {a, {b, a + b}} end)
  end
end

ExUnit.start

defmodule RecursionTest do
  use ExUnit.Case
  doctest Fib
end
