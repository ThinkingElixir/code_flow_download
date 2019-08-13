defmodule CodeFlow.With do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.Schemas.Order
  # alias CodeFlow.Fake.Customers
  # alias CodeFlow.Fake.Orders
  # alias CodeFlow.Fake.Items

  @spec place_new_order(customer_id :: integer, item_id :: integer, quantity :: integer) ::
          {:ok, Order.t()} | {:error, String.t()}
  def place_new_order(customer_id, item_id, quantity) do

  end

end
