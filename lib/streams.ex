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
    |> Enum.map(&(&1 <> ".00"))
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
    |> Enum.map(&IO.inspect("$#{&1}.00", label: "Step 4"))
    |> Enum.take(5)
  end

  def steps_in_enum3(data) do
    self() |> Process.info() |> Keyword.get(:heap_size) |> IO.inspect(label: "Process heap size BEFORE")
    data
    |> Enum.map(&(&1 * 2))
    |> Enum.map(&(&1 + 3))
    |> Enum.map(&(to_string(&1)))
    |> Enum.map(&("$#{&1}.00"))
    |> Enum.take(5)
    self() |> Process.info() |> Keyword.get(:heap_size) |> IO.inspect(label: "Process heap size AFTER")
    :ok
  end

  # NOTE: This is NOT precise. Strings are managed on a separate binary heap,
  # garbage collection kicks in for long running processes, etc. This just helps
  # give a snapshot idea of what's going on.
  #
  # CodeFlow.Streams.steps_in_enum3(1..10_000_000)

  def steps_in_stream(data) do
    data
    |> IO.inspect(label: "original")
    |> Stream.map(&(&1 * 2))
    |> IO.inspect(label: "* 2")
    |> Stream.map(&(&1 + 3))
    |> IO.inspect(label: "+ 3")
    |> Stream.map(&to_string(&1))
    |> IO.inspect(label: "to_string")
    |> Stream.map(&"$#{&1}.00")
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
    |> Stream.map(&IO.inspect("$#{&1}.00", label: "Step 4"))
    |> Enum.take(5)
  end

  def steps_in_stream3(data) do
    self() |> Process.info() |> Keyword.get(:heap_size) |> IO.inspect(label: "Process heap size BEFORE")
    data
    |> Stream.map(&(&1 * 2))
    |> Stream.map(&(&1 + 3))
    |> Stream.map(&(to_string(&1)))
    |> Stream.map(&("$#{&1}.00"))
    |> Enum.take(5)
    self() |> Process.info() |> Keyword.get(:heap_size) |> IO.inspect(label: "Process heap size AFTER")
    :ok
  end

# CodeFlow.Streams.steps_in_enum2([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
# CodeFlow.Streams.steps_in_stream2([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
# TODO: create a graphic that explains/shows the Enum process and one for the Stream process
# The Stream doesn't execute a single call until something requests a value. Enum functions will do that.

  # CodeFlow.Streams.steps_in_stream3(1..10_000_000)


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

# CodeFlow.Streams.steps_in_enum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
# CodeFlow.Streams.steps_in_stream2([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
# :erlang.garbage_collect()

# Using System Monitor, able to see the `beam.smp` process, do work, grow RAM and do some level of GC. Force GC, run the stream version. Very fast, no RAM increase!

# Code organization Notes
#
# -- This is really about RDMBs design
#
# They share 99% of information, the only difference are `is_client` and `is_supplier` fields
# It's for an internal invoicing and office management tool

# gregvaughn
# `parties` is how old-school Data Architects referred to that sort of thing
# a `party` represents some individual or group that can engage in some other relationship
# I learned it from a co-worker when I was at a bank. Here's a reasonable result from googling "data architecture pattern party" http://tdan.com/a-universal-person-and-organization-data-model/5014
