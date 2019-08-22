defmodule CodeFlow.CaseTest do
  @moduledoc """
  Complete the code to make the tests pass. Use the `case` statement to solve
  the failing tests.
  """
  use ExUnit.Case
  alias CodeFlow.Schemas.User
  alias CodeFlow.Case

  describe "simple_example/?" do
    # TODO: want a simpler example. Based on solution from Pattern Matching?
    # TODO: use of case statement with guard clauses?
    #
    # TODO: could be same kind of example that would be otherwise done with
    # function clauses. Show how it can be done with a case. Could express my preference?

    test "idenitifies minors" do
      assert {:ok, :minor} == Case.classify_user(%User{name: "Jill", age: 10})
      assert {:ok, :minor} == Case.classify_user(%User{name: "Bill", age: 17})
      assert {:ok, :minor} == Case.classify_user(%User{name: "Annie", age: 7})
    end

    test "identifies legal US adults" do
      assert {:ok, :adult} == Case.classify_user(%User{name: "Tom", age: 50})
      assert {:ok, :adult} == Case.classify_user(%User{name: "Mary", age: 35})
      assert {:ok, :adult} == Case.classify_user(%User{name: "Lizzie", age: 18})
    end

    test "anything else is :invalid" do
      assert {:error, :invalid} == Case.classify_user(%User{name: "Nilbo", age: nil})
      assert {:error, :invalid} == Case.classify_user(%User{name: "Time Travis", age: -100})
      assert {:error, :invalid} == Case.classify_user("a string")
      assert {:error, :invalid} == Case.classify_user(40)
    end
  end

  describe "read_file/1" do
    # TODO: create sample file for test
    test "returns file contents when file found" do
      assert false
    end

    test "returns error when file not found" do
      # handle :enoent?
      assert false
    end
  end

  describe "find_user/1" do
    test "returns User struct when found" do
      assert false
    end

    test "returns error tuple when with explanation when not found" do
      assert false
    end
  end
end
