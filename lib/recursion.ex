defmodule CodeFlow.Recursion do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Fake.Customers
  alias CodeFlow.Schemas.Customer

  @doc """
  Sum a list of OrderItems to compute the order total.
  """
  def order_total(_order_items) do

  end

  @doc """
  Count the number of active customers. Note: Normally this would be done with a
  query to an SQL database. This is just to practice conditionally incrementing
  a counter and looping using recursion.
  """
  def count_active(customers) do
    do_count_active(customers, 0)
  end

  # Active customer, increment counter and recurse
  defp do_count_active([%Customer{active: true} | rest], acc) do
    do_count_active(rest, acc + 1)
  end

  # Not active, don't increment counter, continue recursing
  defp do_count_active([_customer | rest], acc) do
    do_count_active(rest, acc)
  end

  # Reached end of list, return total count
  defp do_count_active([], acc) do
    acc
  end

  @doc """
  Create the desired number of customers. Provide the number of customers to
  create. Something like this could be used in a testing setup.
  """
  def create_customers(number) do
    do_create_customers(number, 0)
  end

  defp do_create_customers(total, num) when num < total do
    result =
      case Customers.create(%{name: "Customer #{num}"}) do
        {:ok, _customer} ->
          :ok

        {:error, _reason} ->
          :error
      end

    # TODO: I don't know how to clean this up yet. Honestly, I wouldn't write it this way. Think.
    if result == :ok do
      do_create_customers(total, num + 1)
    else
      :error
    end
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
