defmodule CodeFlow.Railway do
  @moduledoc """
  Defining a workflow or "code flow" using the Railway pattern.
  """
  alias CodeFlow.User

  @doc """
  Works well when the functions are designed to pass the output of one
  level as the input of the next function.
  """
  def award_points(%User{} = _user, _inc_point_value) do

  end

end
