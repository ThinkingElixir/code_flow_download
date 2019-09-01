defmodule CodeFlow.Recursion do
  alias CodeFlow.Fake.Customers

  @moduledoc """
  Fix or complete the code to make the tests pass.
  """

  @doc """
  Sum a list of numbers using recursion.
  """
  def sum_numbers(_numbers) do
  end

  @doc """
  Sum a list of purchases. A "purchase" entry is a map.
  """
  def sum_purchases(_customers) do
  end

  def create_customers(number) do
    do_create_customers(number, 0)
  end

  defp do_create_customers(total, num) when num < total do
    case Customers.create(%{name: "Customer #{num}"}) do
      {:ok, _customer} ->
        :ok

      {:error, _reason} ->
      # TODO: Don't raise!? Keep a good API
        raise "Failed trying to create customer!"
    end
    do_create_customers(total, num + 1)
  end

  defp do_create_customers(total, _num) do
    "Created #{total} customers!"
  end

  @doc """
  Compute the value in the Fibonacci sequence for the number. If the number is
  "10", then the result is 10 plus the value of the 9th index of the fibonacci
  sequence.

  https://en.wikipedia.org/wiki/Fibonacci_number
  """
  def fibonacci(0), do: 0
  def fibonacci(1), do: 1

  def fibonacci(index) do
    fibonacci(index - 2) + fibonacci(index - 1)
  end
end
