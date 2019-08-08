defmodule CodeFlow.Fake.Schemas.Item do
  @moduledoc """
  Simplified non-database struct that represents an Item. Used for examples.
  """
  alias __MODULE__

  defstruct [
    :id,
    :name,
    {:weight, 0.0},
    {:active, true}
  ]

  @type t :: %Item{
          id: nil | integer(),
          name: nil | String.t(),
          weight: float(),
          active: boolean()
        }
end
