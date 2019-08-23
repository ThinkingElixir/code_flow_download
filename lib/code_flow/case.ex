defmodule CodeFlow.Case do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Schemas.User

  def classify_user(user) do
    case user do
      %User{age: nil} ->
        {:error, "Age is required"}

      %User{age: age} when age >= 18 ->
        {:ok, :adult}

      %User{age: age} when age >= 0 and age < 18 ->
        {:ok, :minor}

      _ ->
        {:error, :invalid}
    end
  end

  def read_file(filename) do
    case File.read(filename) do
      {:ok, contents} ->
        {:ok, contents}

      {:error, :enoent} ->
        {:error, "File not found"}
    end
  end

  def find_user(_user_id) do
  end
end
