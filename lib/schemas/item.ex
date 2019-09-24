defmodule CodeFlow.Schemas.Item do
  @moduledoc """
  Simplified non-database struct that represents an Item. Used for examples.
  """
  alias __MODULE__

  defstruct [
    :id,
    :name,
    {:price, 0.0},
    {:weight, 0.0},
    {:quantity, 1},
    {:active, true}
  ]

  @type t :: %Item{
          id: nil | integer(),
          name: nil | String.t(),
          price: float(),
          quantity: integer(),
          weight: float(),
          active: boolean()
        }
end
