defmodule CodeFlow.With.AwardPointsTest do
  @moduledoc """
  Complete the code to make the tests pass. Use a `with` statement to perform
  the workflow.
  """
  use ExUnit.Case
  alias CodeFlow.Schemas.User
  alias CodeFlow.With.AwardPoints

  # INSTRUCTIONS:
  # =============
  # - Reject User's who are not active.
  # - Reject User's who's age is < 16.
  # - Reject User's who's name is in the hardcoded blacklist ["Tom", "Tim", "Tammy"].
  # - Increment the all other user's points by 100

  describe "award_points/2" do
    test "increments valid user's points by the desired amount" do
      user = %User{name: "Howard", active: true, points: 0, age: 22}
      {:ok, %User{} = updated_user} = AwardPoints.award_points(user, 100)
      assert updated_user.points == 100

      {:ok, %User{points: 120}} = AwardPoints.award_points(updated_user, 20)
    end

    test "rejects inactive users" do
      {:error, reason} = AwardPoints.award_points(%User{name: "Howard", active: false}, 10)
      assert reason == "Not an active User"
    end

    test "rejects under-age users" do
      {:error, reason} = AwardPoints.award_points(%User{name: "Howard", active: true, age: 15}, 10)
      assert reason == "User age is below the cuttoff"
    end

    test "rejects users on the blacklist" do
      blacklist = ["Tom", "Tim", "Tammy"]
      Enum.each(blacklist, fn(name) ->
        user = %User{name: name, active: true, age: 20}
        {:error, reason} = AwardPoints.award_points(user, 10)
        assert reason == "User #{inspect(name)} is blacklisted"
      end)
    end
  end

  # ###
  # ### If you want a more explicit walk-through on the suggested steps,
  # ### then use the following tests as a guide. The individual functions could
  # ### be either public or private and may or may not be tested individually.
  # ###

  # describe "validate_is_active/1" do
  #   test "returns {:ok, user} when active" do
  #     user = %User{name: "Tom", active: true}
  #     assert {:ok, user} == AwardPoints.validate_is_active(user)
  #   end

  #   test "returns error when not an active user" do
  #     user = %User{name: "Tom", active: false}
  #     assert {:error, "Not an active User"} == AwardPoints.validate_is_active(user)
  #     assert {:error, "Not an active User"} == AwardPoints.validate_is_active(123)
  #   end
  # end

  # describe "validate_at_least_age/2" do
  #   test "returns {:ok, user} when meets age requirement" do
  #     user = %User{name: "Tom", active: true, age: 10}
  #     assert {:ok, user} == AwardPoints.validate_at_least_age({:ok, user}, 1)
  #     assert {:ok, user} == AwardPoints.validate_at_least_age({:ok, user}, 9)
  #     assert {:ok, user} == AwardPoints.validate_at_least_age({:ok, user}, 10)
  #   end

  #   test "returns error when does not meet age requirement" do
  #     user = %User{name: "Tom", active: true, age: 9}
  #     assert {:error, "User age is below the cuttoff"} == AwardPoints.validate_at_least_age({:ok, user}, 10)
  #     assert {:error, "User age is below the cuttoff"} == AwardPoints.validate_at_least_age({:ok, user}, 11)
  #     assert {:error, "User age is below the cuttoff"} == AwardPoints.validate_at_least_age({:ok, user}, 30)
  #     # passes through whatever given from higher level
  #     assert {:error, "other stuff"} == AwardPoints.validate_at_least_age({:error, "other stuff"}, 20)
  #     assert "not a user" == AwardPoints.validate_at_least_age("not a user", 20)
  #   end
  # end

  # describe "check_name_blacklist/1" do
  #   test "returns {:ok, user} when name not in blacklist" do
  #     user1 = %User{name: "Joan"}
  #     user2 = %User{name: "Howard"}
  #     user3 = %User{name: "Ben"}
  #     assert {:ok, user1} == AwardPoints.check_name_blacklist({:ok, user1})
  #     assert {:ok, user2} == AwardPoints.check_name_blacklist({:ok, user2})
  #     assert {:ok, user3} == AwardPoints.check_name_blacklist({:ok, user3})
  #   end

  #   test "returns error when name is in blacklist" do
  #     blacklist = ["Tom", "Tim", "Tammy"]
  #     Enum.each(blacklist, fn(name) ->
  #       user = %User{name: name}
  #       {:error, reason} = AwardPoints.check_name_blacklist({:ok, user})
  #       assert reason == "User #{inspect(name)} is blacklisted"
  #     end)
  #   end
  # end

  # describe "increment_points/2" do
  #   test "increments points by desired amount" do
  #     user = %User{name: "Steve", age: 50, points: 200}
  #     assert {:ok, %User{points: 220}} = AwardPoints.increment_points({:ok, user}, 20)
  #     assert {:ok, %User{points: 195}} = AwardPoints.increment_points({:ok, user}, -5)
  #     assert {:ok, %User{points: 400}} = AwardPoints.increment_points({:ok, user}, 200)
  #   end

  #   test "returns whatever was passed in if not {:ok, user}" do
  #     assert {:error, "Wrong"} == AwardPoints.increment_points({:error, "Wrong"}, 10)
  #     assert 123 == AwardPoints.increment_points(123, 10)
  #   end
  # end
end
