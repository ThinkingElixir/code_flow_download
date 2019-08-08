defmodule CodeFlow.Fake.Schemas.Item do
  @moduledoc """
  Simplified non-database struct that represents an Item. Used for examples.
  """
  alias __MODULE__

  @enforce_keys [:id, :name]
  defstruct [
    :id,
    :name,
    {:weight, 0.0},
    {:quantity, 0},
    {:active, true}
  ]

  @type t :: %Item{
          id: integer(),
          name: String.t(),
          weight: float(),
          quantity: integer(),
          active: boolean()
        }
end
