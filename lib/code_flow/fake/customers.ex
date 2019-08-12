defmodule CodeFlow.Fake.Customers do
  @moduledoc """
  Fake interface for working with Customers. This gives a more realistic API
  interface without worrying about databases. Keeps us focused on the code we
  are working on.
  """
  alias CodeFlow.Schemas.Customer
  alias CodeFlow.Schemas.Order

  @doc """
  Find a customer by it's unique ID.

  NOTE: This only provides canned data for use in the examples and practice
  exercises.
  """
  @spec find(id :: integer()) :: {:ok, Customer.t()} | {:error, String.t()}
  def find(id) when is_integer(id) do
    database = %{
      1 => %Customer{
        id: 1,
        name: "Squiggles and Blopps",
        contact_name: "Sally",
        contact_email: "sally@example.com"
      },
      2 => %Customer{
        id: 2,
        name: "ACME, Inc",
        contact_name: "Gary",
        contact_email: "gary@example.com"
      },
      3 => %Customer{
        id: 3,
        name: "Clown Supply Store",
        contact_name: "Howard",
        contact_email: nil
      },
      4 => %Customer{
        id: 4,
        name: "[INACTIVE] Lethargy Inc",
        contact_name: "Lucy",
        contact_email: "lucy@example.com",
        active: false
      },
      5 => %Customer{
        id: 5,
        name: "Always Broken, Co.",
        contact_name: "Bruce",
        contact_email: "bruce@example.com"
      }
    }

    case Map.get(database, id) do
      nil -> {:error, "Customer not found"}
      %Customer{} = customer -> {:ok, customer}
    end
  end

  @type event :: {atom(), any()}

  @doc """
  Notify a customer that an event occurred. The event is a tuple of the event
  name/type and any related data.

  NOTE: This only provides a mock interface for the practice examples. This
  sends a message to the process running the code, in the case of tests, it will
  be the test runner process. The test uses this message passing to observe that
  a created side-effect was triggered correctly. In a "real" system, you might
  instead observe the side-effects of a created email, SMS, etc.
  """
  @spec notify(Customer.t(), event) :: :ok | {:error, String.t() | :timeout}
  def notify(%Customer{contact_email: nil} = _customer, _event),
    do: {:error, "Customer contact email missing"}

  def notify(%Customer{id: 5} = _customer, _event),
    do: {:error, :timeout}

  def notify(%Customer{} = _customer, {:order_placed, %Order{} = _order} = event) do
    send(self(), {:notify, event})
    :ok
  end
end
