defmodule CodeFlow.EnumShortcut do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Fake.Customers
  alias CodeFlow.Schemas.OrderItem

  @doc """
  Create the desired number of customers. Provide the number of customers to
  create. Something like this could be used in a testing setup.
  """
  def create_customers(0), do: :ok

  def create_customers(number) do
    Enum.each(1..number, fn(num) ->
      # for simplicity, not handling a failed create
      {:ok, _customer} = Customers.create(%{name: "Customer #{num}"})
    end)
  end

  # @doc """
  # Sum a list of OrderItems to compute the order total.
  # """
  # def order_total(_order_items) do

  # end

  @doc """
  Sum a list of OrderItems to compute the order total.
  """
  def order_total(order_items) do
    Enum.reduce(order_items, 0, fn(%OrderItem{} = order_item, total) ->
      (order_item.quantity * order_item.item.price) + total
    end)
  end

end
