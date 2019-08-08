defmodule CodeFlow.With.AwardPoints do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.User

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
end
