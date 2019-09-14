defmodule CodeFlow.Errors do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Fake.Orders
  alias CodeFlow.Fake.Users
  # alias CodeFlow.Schemas.Order

  def find_user(id) do
    case Users.find(id) do
      {:ok, user} ->
        user

      {:error, reason} ->
        raise reason
    end
  end

  def find_order!(id) do
    {:ok, Orders.find!(id)}
  rescue
    e in RuntimeError ->
      {:error, e.message}
  end
end
