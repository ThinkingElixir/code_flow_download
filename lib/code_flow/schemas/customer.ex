defmodule CodeFlow.Schemas.Customer do
  @moduledoc """
  Simplified non-database struct that represents a Customer. Used for examples.
  """
  alias __MODULE__

  defstruct [
    :id,
    :name,
    :location,
    :contact_name,
    :contact_number,
    {:orders, []},
    {:active, true}
  ]

  @type t :: %Customer{
          id: nil | integer(),
          name: nil | String.t(),
          location: nil | String.t(),
          contact_name: nil | String.t(),
          contact_number: nil | String.t(),
          orders: list(),
          active: boolean()
        }
end
