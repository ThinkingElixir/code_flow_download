defmodule CodeFlow.With do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.Schemas.User
  alias CodeFlow.Schemas.Order
  alias CodeFlow.Fake.Customers
  alias CodeFlow.Fake.Orders
  alias CodeFlow.Fake.Items

  @doc """
  Works well when the functions are designed to pass the output of one
  step as the input of the next function.
  """
  def award_points(%User{} = user, inc_point_value) do
    with {:ok, user} <- validate_is_active(user),
         {:ok, user} <- validate_at_least_age(user, 16),
         {:ok, user} <- check_name_blacklist(user) do
      {:ok, increment_points(user, inc_point_value)}
    end
  end

  # TODO: "with" works well for pulling different things together then using them when all found
  # TODO: create mock modules that return canned factory data. Can use to illustrate the "with" statement
  #       Can use the same functions in a railway pipeline. Purpose built functions might be needed to make it flow well. (Good example)

  def validate_is_active(%User{active: true} = user) do
    {:ok, user}
  end

  def validate_is_active(_user) do
    {:error, "Not an active User"}
  end

  def validate_at_least_age(%User{age: age} = user, cuttoff_age) when age >= cuttoff_age do
    {:ok, user}
  end

  def validate_at_least_age(_user, _cuttoff_age) do
    {:error, "User age is below the cuttoff"}
  end

  def check_name_blacklist(%User{name: name} = _user)
      when name in ["Tom", "Tim", "Tammy"] do
    {:error, "User #{inspect(name)} is blacklisted"}
  end

  def check_name_blacklist(%User{} = user) do
    {:ok, user}
  end

  def check_name_blacklist({:error, _reason} = error), do: error

  def increment_points(%User{points: points} = user, inc_by) do
    %User{user | points: points + inc_by}
  end

  # Benefits: pull disparate re-usable business logic functions together into an
  # ad-hoc flow.
  #
  # See the benefit of functions returning tuples? It is easier for pattern matching.
  # If both Customers.find/1 and Items.find/1 returned `nil` when not found, you
  # couldn't tell the difference in the `else` for "what" required thing wasn't
  # found.
  #
  # No "else" would be required if the timeout error had been handled and instead returned a string.

  @spec place_new_order(customer_id :: integer, item_id :: integer, quantity :: integer) ::
          {:ok, Order.t()} | {:error, String.t()}
  def place_new_order(customer_id, item_id, quantity) do
    with {:ok, customer} <- Customers.find(customer_id),
         {:ok, item} <- Items.find(item_id),
         {:ok, order} <- Orders.new(customer),
         {:ok, order} <- Orders.add_item(order, item, quantity),
         :ok <- Customers.notify(customer, {:order_placed, order}) do
      {:ok, order}
    else
      {:error, :timeout} ->
        {:error, "Timed out attempting to notify customer"}

      error ->
        error
    end
  end

  # TODO: explain that no "else" condition results in the error being returned directly.
end
