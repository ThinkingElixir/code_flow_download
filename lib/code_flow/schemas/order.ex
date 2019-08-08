defmodule CodeFlow.Fake.Schemas.Order do
  @moduledoc """
  Simplified non-database struct that represents an Order. Used for examples.
  """
  alias __MODULE__

  defstruct [
    :id,
    :name,
    :customer,
    {:order_items, []},
    {:active, true}
  ]

  @type t :: %Order{
          id: nil | integer(),
          name: nil | String.t(),
          customer: nil | Customer.t(),
          order_items: [OrderItem.t()],
          active: boolean()
        }
end
