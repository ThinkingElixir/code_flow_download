defmodule CodeFlow.Fake.Schemas.OrderItem do
  @moduledoc """
  Simplified non-database struct that represents an OrderItem. Used for examples.
  """
  alias __MODULE__
  alias CodeFlow.Fake.Schemas.Item

  defstruct [
    :id,
    :item,
    {:quantity, 0}
  ]

  @type t :: %OrderItem{
          id: nil | integer(),
          item: nil | Item.t(),
          quantity: integer()
        }
end
