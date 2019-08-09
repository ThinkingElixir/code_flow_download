defmodule CodeFlow.Fake.Items do
  @moduledoc """
  Fake interface for working with Items. This gives a more realistic API
  interface without worrying about databases. Keeps us focused on the code we
  are working on.
  """
  alias CodeFlow.Schemas.Item

  @doc """
  Find an item by it's unique ID.

  NOTE: This only provides canned data for use in the examples and practice
  exercises.
  """
  @spec find(id :: integer()) :: {:ok, Item.t()} | {:error, String.t()}
  def find(id) when is_integer(id) do
    database = %{
      10 => %Item{id: 10, name: "Premium Clown Noses, 20 pc", weight: 1.5},
      20 => %Item{id: 20, name: "Party Streamers", weight: 1.0},
      30 => %Item{id: 30, name: "[INACTIVE] Cleaning Gloves", weight: 0.5, active: false}
    }

    case Map.get(database, id) do
      nil -> {:error, "Item not found"}
      %Item{} = item -> {:ok, item}
    end
  end

end
