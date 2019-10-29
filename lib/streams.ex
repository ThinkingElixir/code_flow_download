defmodule CodeFlow.Streams do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  # alias CodeFlow.Fake.Customers
  # alias CodeFlow.Schemas.OrderItem

  def steps_in_enum(data) do
    data
    |> IO.inspect(label: "original")
    |> Enum.map(&(&1 * 2))
    |> IO.inspect(label: "* 2")
    |> Enum.map(&(&1 + 3))
    |> IO.inspect(label: "+ 3")
    |> Enum.map(&to_string(&1))
    |> IO.inspect(label: "to_string")
    |> Enum.map(&(&1 <> " bottles of..."))
  end

  def steps_in_enum2(data) do
    data
    |> IO.inspect(label: "original")
    |> Enum.map(&IO.inspect(&1 * 2, label: "Step 1"))
    |> IO.inspect(label: "* 2")
    |> Enum.map(&IO.inspect(&1 + 3, label: "Step 2"))
    |> IO.inspect(label: "+ 3")
    |> Enum.map(&IO.inspect(to_string(&1), label: "Step 3"))
    |> IO.inspect(label: "to_string")
    |> Enum.map(&IO.inspect(&1 <> " bottles of...", label: "Step 4"))
    |> Enum.take(5)
  end

  def steps_in_stream(data) do
    data
    |> IO.inspect(label: "original")
    |> Stream.map(&(&1 * 2))
    |> IO.inspect(label: "* 2")
    |> Stream.map(&(&1 + 3))
    |> IO.inspect(label: "+ 3")
    |> Stream.map(&to_string(&1))
    |> IO.inspect(label: "to_string")
    |> Stream.map(&(&1 <> " bottles of..."))
    |> IO.inspect(label: "final")
    |> Enum.to_list()
  end

  def steps_in_stream2(data) do
    data
    |> IO.inspect(label: "original")
    |> Stream.map(&IO.inspect(&1 * 2, label: "Step 1"))
    |> IO.inspect(label: "* 2")
    |> Stream.map(&IO.inspect(&1 + 3, label: "Step 2"))
    |> IO.inspect(label: "+ 3")
    |> Stream.map(&IO.inspect(to_string(&1), label: "Step 3"))
    |> IO.inspect(label: "to_string")
    |> Stream.map(&IO.inspect(&1 <> " bottles of...", label: "Step 4"))
    |> Enum.take(5)
  end


  @doc """
  Create the desired number of customers. Provide the number of customers to
  create. Something like this could be used in a testing setup.
  """
  def create_customers(_number) do
  end

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
  def count_active(_customers) do
  end
end

CodeFlow.Streams.steps_in_enum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
