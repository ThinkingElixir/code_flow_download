defmodule CodeFlow.Railway do
  @moduledoc """
  Defining a workflow or "Code Flow" using the Railway Pattern.
  """
  alias CodeFlow.Schemas.User

  @doc """
  Works well when the functions are designed to pass the output of one
  step as the input of the next function.
  """
  def award_points(%User{} = _user, _inc_point_value) do

  end

end
