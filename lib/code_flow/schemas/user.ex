defmodule CodeFlow.Schemas.User do
  @moduledoc """
  Simplified non-database struct that represents a User. Used for examples.
  """
  alias __MODULE__

  @enforce_keys [:name]
  defstruct [:id, :name, :age, :hair, {:points, 0}, {:admin, false}, {:active, true}]

  @type t :: %User{
          id: nil | integer(),
          name: String.t(),
          age: nil | integer(),
          hair: nil | String.t(),
          points: integer(),
          admin: boolean,
          active: boolean()
        }
end
