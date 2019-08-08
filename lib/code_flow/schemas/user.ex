defmodule CodeFlow.Schemas.User do
  @moduledoc """
  Simplified non-database struct that represents a User. Used for examples.
  """
  alias __MODULE__

  @enforce_keys [:name]
  defstruct [:name, :age, :hair, :gender, {:points, 0}, {:admin, false}, {:active, true}]

  @type t :: %User{
          name: String.t(),
          age: nil | integer(),
          hair: nil | String.t(),
          gender: nil | :male | :female,
          points: integer(),
          admin: boolean,
          active: boolean()
        }
end
