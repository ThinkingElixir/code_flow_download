defmodule CodeFlow.Fake.Users do
  @moduledoc """
  Fake interface for working with Users. This gives a more realistic API
  interface without worrying about databases. Keeps us focused on the code we
  are working on.
  """
  alias CodeFlow.Schemas.User

  @user_db %{
    1 => %User{
      id: 1,
      name: "Squiggles and Blopps",
      contact_name: "Sally",
      contact_email: "sally@example.com"
    },
    2 => %User{
      id: 2,
      name: "ACME, Inc",
      contact_name: "Gary",
      contact_email: "gary@example.com"
    },
    3 => %User{
      id: 3,
      name: "Clown Supply Store",
      contact_name: "Howard",
      contact_email: nil
    },
    4 => %User{
      id: 4,
      name: "[INACTIVE] Lethargy Inc",
      contact_name: "Lucy",
      contact_email: "lucy@example.com",
      active: false
    },
    5 => %User{
      id: 5,
      name: "Always Broken, Co.",
      contact_name: "Bruce",
      contact_email: "bruce@example.com"
    }
  }

  @doc """
  A simplified simulation of a Repo.one/2 call. Takes an ID, looks up the
  User entry. If not found, a `nil` is returned.
  """
  @spec one(id :: integer) :: nil | User.t()
  def one(id) do
    Map.get(@user_db, id)
  end

  @doc """
  Find a user by it's unique ID.

  NOTE: This only provides canned data for use in the examples and practice
  exercises.
  """
  @spec find(id :: integer()) :: {:ok, User.t()} | {:error, String.t()}
  def find(id) when is_integer(id) do
    case Map.get(@user_db, id) do
      nil -> {:error, "User not found"}
      %User{} = user -> {:ok, user}
    end
  end

end
