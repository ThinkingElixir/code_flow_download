defmodule CodeFlow.ErrorsTest do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  use ExUnit.Case
  alias CodeFlow.Errors
  alias CodeFlow.Schemas.User

  describe "find_user/1" do
    test "returns the user as an :ok tuple when found" do
      {:ok, %User{} = user} = Errors.find_user(1)
      assert user.id == 1
    end

    test "returns an :error tuple when not found with expected message" do
      {:error, reason} = Errors.find_user(99)
      assert reason == "User not found"

      {:error, reason} = Errors.find_user(-1)
      assert reason == "Database connection failure!"
    end
  end
end
