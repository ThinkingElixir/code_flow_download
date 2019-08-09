defmodule CodeFlow.Fake.Customers do
  @moduledoc """
  Fake interface for working with Customers. This gives a more realistic API
  interface without worrying about databases. Keeps us focused on the code we
  are working on.
  """
  alias CodeFlow.Schemas.Customer

  @doc """
  Find a customer by it's unique ID.

  NOTE: This only provides canned data for use in the examples and practice
  exercises.
  """
  @spec find(id :: integer()) :: {:ok, Customer.t()} | {:error, String.t()}
  def find(id) when is_integer(id) do
    database = %{
      1 => %Customer{id: 1, name: "Squiggles and Blopps", contact_name: "Sally", contact_email: "sally@example.com"},
      2 => %Customer{id: 2, name: "ACME, Inc", contact_name: "Gary", contact_email: "gary@example.com"},
      3 => %Customer{id: 3, name: "Clown Supply Store", contact_name: "Howard", contact_email: "howard@example.com"},
      4 => %Customer{id: 4, name: "[INACTIVE] Lethargy Inc", contact_name: "Lucy", contact_email: "lucy@example.com", active: false}
    }

    case Map.get(database, id) do
      nil -> {:error, "Customer not found"}
      %Customer{} = customer -> {:ok, customer}
    end
  end

end
