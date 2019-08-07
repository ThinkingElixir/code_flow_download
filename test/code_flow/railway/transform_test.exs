defmodule CodeFlow.Railway.AwardPointsTest do
  @moduledoc """
  Complete the code to make the tests pass. Use the Railway Pattern to create
  steps in the workflow.
  """
  use ExUnit.Case
  alias CodeFlow.User
  alias CodeFlow.Railway.Transform


  # TODO: could have another step lookup a mapping from another file. The mapping can return a "not found" error.


  # INSTRUCTIONS:
  # =============
  # - Reject User's who are not active.
  # - Reject User's who's age is < 16.
  # - Reject User's who's name is in the hardcoded blacklist ["Tom", "Tim", "Tammy"].
  # - Increment the all other user's points by 100

  # describe "award_points/2" do
  #   test "increments valid user's points by the desired amount" do
  #     user = %User{name: "Howard", active: true, points: 0, age: 22}
  #     {:ok, %User{} = updated_user} = AwardPoints.award_points(user, 100)
  #     assert updated_user.points == 100

  #     {:ok, %User{points: 120}} = AwardPoints.award_points(updated_user, 20)
  #   end

  #   test "rejects inactive users" do
  #     {:error, reason} = AwardPoints.award_points(%User{name: "Howard", active: false}, 10)
  #     assert reason == "Not an active User"
  #   end

  #   test "rejects under-age users" do
  #     {:error, reason} = AwardPoints.award_points(%User{name: "Howard", active: true, age: 15}, 10)
  #     assert reason == "User age is below the cuttoff"
  #   end

  #   test "rejects users on the blacklist" do
  #     blacklist = ["Tom", "Tim", "Tammy"]
  #     Enum.each(blacklist, fn(name) ->
  #       user = %User{name: name, active: true, age: 20}
  #       {:error, reason} = AwardPoints.award_points(user, 10)
  #       assert reason == "User #{inspect(name)} is blacklisted"
  #     end)
  #   end
  # end
end
