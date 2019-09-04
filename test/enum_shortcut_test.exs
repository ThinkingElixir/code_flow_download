defmodule CodeFlow.EnumShortcutTest do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  use ExUnit.Case
  alias CodeFlow.EnumShortcut
  alias CodeFlow.Schemas.OrderItem
  alias CodeFlow.Schemas.Item

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

  describe "order_total/1" do
    test "returns 0 for an empty list" do
      assert 0 == EnumShortcut.order_total([])
    end

    test "sums the total for all OrderItems in a list" do
      order_items = [
        %OrderItem{quantity: 2, item: %Item{name: "Item 1", price: 5.00}},
        %OrderItem{quantity: 1, item: %Item{name: "Item 2", price: 8.75}},
        %OrderItem{quantity: 3, item: %Item{name: "Item 3", price: 2.50}},
        %OrderItem{quantity: 10, item: %Item{name: "Item 4", price: 11.00}},
        %OrderItem{quantity: 0, item: %Item{name: "Item 5", price: 1.00}}
      ]
      assert 136.25 == EnumShortcut.order_total(order_items)
    end
  end

end
