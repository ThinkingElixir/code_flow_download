defmodule CodeFlow.Schemas.Order do
  @moduledoc """
  Simplified non-database struct that represents an Order. Used for examples.
  """
  alias __MODULE__

  defstruct [
    :id,
    :customer,
    {:order_items, []},
    {:active, true}
  ]

  @type t :: %Order{
          id: nil | integer(),
          customer: nil | Customer.t(),
          order_items: [OrderItem.t()],
          active: boolean()
        }
end
