defmodule CodeFlow.With do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.Fake.Customers
  alias CodeFlow.Fake.Orders
  alias CodeFlow.Fake.Items

  # Benefits: pull disparate re-usable business logic functions together into an
  # ad-hoc flow.
  #
  # See the benefit of functions returning tuples? It is easier for pattern matching.
  # If both Customers.find/1 and Items.find/1 returned `nil` when not found, you
  # couldn't tell the difference in the `else` for "what" required thing wasn't
  # found.
  #
  # No "else" would be required if the timeout error had been handled and instead returned a string.

  @spec place_new_order(customer_id :: integer, item_id :: integer, quantity :: integer) ::
          {:ok, CodeFlow.Schemas.Order.t()} | {:error, String.t()}
  def place_new_order(customer_id, item_id, quantity) do
    with {:ok, customer} <- Customers.find(customer_id),
         {:ok, item} <- Items.find(item_id),
         {:ok, order} <- Orders.new(customer),
         {:ok, order} <- Orders.add_item(order, item, quantity),
         :ok <- Customers.notify(customer, {:order_placed, order}) do
      {:ok, order}
    else
      {:error, :timeout} ->
        {:error, "Timed out attempting to notify customer"}

      error ->
        error
    end
  end

  # TODO: explain that no "else" condition results in the error being returned directly.
end
