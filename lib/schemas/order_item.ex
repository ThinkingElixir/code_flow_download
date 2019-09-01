defmodule CodeFlow.Schemas.OrderItem do
  @moduledoc """
  Simplified non-database struct that represents an OrderItem. Used for examples.
  """
  alias __MODULE__
  alias CodeFlow.Schemas.Item

  defstruct [
    :item,
    {:quantity, 0}
  ]

  @type t :: %OrderItem{
          item: nil | Item.t(),
          quantity: integer()
        }
end
