defmodule CodeFlow.RecursionTest do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  use ExUnit.Case
  alias CodeFlow.Recursion

  describe "sum_numbers/1" do
    test "returns 0 for an empty list" do
      assert 0 == Recursion.sum_numbers([])
    end

    test "returns the number for a single item" do
      assert 100 == Recursion.sum_numbers([100])
    end

    test "sums all items in a list together" do
      numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      assert 45 == Recursion.sum_numbers(numbers)
    end
  end

  describe "sum_purchases/1" do
    test "returns 0 for an empty list" do
      assert 0 == Recursion.sum_purchases([])
    end

    test "sums the purchases for all maps in a list" do
      customers = [
        %{name: "Customer 1", purchases: 10_000},
        %{name: "Customer 2", purchases: 25},
        %{name: "Customer 3", purchases: 100},
        %{name: "Customer 4", purchases: 550},
        %{name: "Customer 5", purchases: 250}
      ]
      assert 10_925 == Recursion.sum_purchases(customers)
    end
  end

  describe "create_customers/1" do
    test "calls Customers.create/1 correct number of times" do
      assert false
    end

    test "returns text saying how many were created" do
      assert "Created 0 customers!" == Recursion.create_customers(0)
      assert "Created 1 customers!" == Recursion.create_customers(1)
      assert "Created 5 customers!" == Recursion.create_customers(5)
      assert "Created 10 customers!" == Recursion.create_customers(10)
      assert "Created 100 customers!" == Recursion.create_customers(100)
    end
  end

  describe "fibonacci/1" do
    test "computes the fibonacci sequence" do
      # implement a fibonnaci number sequence generator using pattern matching
      # and recursion.
      # Fibonacci series is described as Fib(n) = Fib(n-1) + Fib(n-2)
      # "n" is computed as the sum of the 2 numbers preceeding it.
      # Given the starting values where Fib(0) = 0 and Fib(1) = 1

      assert 0 == Recursion.fibonacci(0)
      assert 1 == Recursion.fibonacci(1)
      assert 1 == Recursion.fibonacci(2)
      assert 2 == Recursion.fibonacci(3)
      assert 3 == Recursion.fibonacci(4)
      assert 5 == Recursion.fibonacci(5)
      assert 8 == Recursion.fibonacci(6)
      assert 13 == Recursion.fibonacci(7)
      assert 21 == Recursion.fibonacci(8)
      assert 610 == Recursion.fibonacci(15)
      assert 10_946 == Recursion.fibonacci(21)
    end
  end
end
