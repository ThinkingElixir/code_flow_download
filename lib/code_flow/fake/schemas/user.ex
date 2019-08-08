defmodule CodeFlow.Fake.Schemas.User do
  @moduledoc """
  User struct used in practice solutions.
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
