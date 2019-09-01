defmodule CodeFlow.With do
  @moduledoc """
  Defining a workflow or "Code Flow" using a `with` statement.
  """
  alias CodeFlow.Schemas.Order
  # alias CodeFlow.Fake.Customers
  # alias CodeFlow.Fake.Orders
  # alias CodeFlow.Fake.Items

  @spec place_new_order(customer_id :: integer, item_id :: integer, quantity :: integer) ::
          {:ok, Order.t()} | {:error, String.t()}
  def place_new_order(_customer_id, _item_id, _quantity) do

  end
end
