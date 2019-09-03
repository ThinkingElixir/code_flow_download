defmodule CodeFlow.EnumShortcutTest do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  use ExUnit.Case
  alias CodeFlow.EnumShortcut

  describe "create_customers/1" do
    test "does not create any when given 0" do
      assert :ok == EnumShortcut.create_customers(0)
      refute_received {:customer_created, _new_customer}
    end

    test "calls Customers.create/1 correct number of times" do
      assert :ok == EnumShortcut.create_customers(3)
      assert_received {:customer_created, _new_customer}
      assert_received {:customer_created, _new_customer}
      assert_received {:customer_created, _new_customer}
      refute_received {:customer_created, _new_customer}
    end
  end

end
