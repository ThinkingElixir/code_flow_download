defmodule CodeFlow.Fake.Orders do
  @moduledoc """
  Fake interface for working with Orders. This gives a more realistic API
  interface without worrying about databases. Keeps us focused on the code we
  are working on.
  """
  alias CodeFlow.Schemas.Order
  alias CodeFlow.Schemas.OrderItem
  alias CodeFlow.Schemas.Customer
  alias CodeFlow.Schemas.Item

  @doc """
  Start a new Order for a customer. Does not allow ordering for an inactive customer.
  """
  @spec new(Customer.t()) :: {:ok, Order.t()} | {:error, String.t()}
  def new(%Customer{active: true} = customer) do
    {:ok, %Order{id: 99, customer: customer}}
  end

  def new(%Customer{} = _customer) do
    {:error, "Cannot create order for inactive customer"}
  end

  def add_item(%Order{} = order, %Item{} = item, quantity) do
    new_order_item = %OrderItem{item: item, quantity: quantity}
    updated_order = %Order{order | order_items: [ new_order_item | order.order_items]}
    {:ok, updated_order}
  end
end
