defmodule CodeFlow.ComprehensionTest do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  use ExUnit.Case
  alias CodeFlow.Comprehension
  alias CodeFlow.Schemas.Customer
  alias CodeFlow.Schemas.OrderItem
  alias CodeFlow.Schemas.Item

  describe "build_chessboard/0" do
    test "returns expected list with maps" do
      # match asserts it returns a list
      [first | _rest] = Comprehension.build_chessboard()
      # match asserts it is a map with the expected keys
      %{row: _row, col: _col, name: _name} = first
    end

    test "includes spot checked values" do
      Comprehension.build_chessboard()
      |> assert_board_contains("a", 1, "a1")
      |> assert_board_contains("a", 8, "a8")
      |> assert_board_contains("b", 2, "b2")
      |> assert_board_contains("c", 3, "c3")
      |> assert_board_contains("d", 4, "d4")
      |> assert_board_contains("e", 5, "e5")
      |> assert_board_contains("f", 6, "f6")
      |> assert_board_contains("g", 7, "g7")
      |> assert_board_contains("h", 1, "h1")
      |> assert_board_contains("h", 8, "h8")
    end

    test "has correct number of squares" do
      board = Comprehension.build_chessboard()
      assert length(board) == 64
    end
  end

  defp assert_board_contains(board, col, row, name) do
    assert is_list(board), "Board should be a list"
    case Enum.  find(board, &(&1.name == name)) do
      %{col: c, row: r} = _found ->
        assert col == c, "Column value is wrong for #{inspect name}"
        assert row == r, "Row value is wrong for #{inspect name}"
        # assertions passed, return the board so we can continue piping
        board

      nil ->
        raise "Board does not contain name #{inspect name}"
    end
  end

  # describe "create_customers/1" do
  #   test "does not create any when given 0" do
  #     assert :ok == Comprehension.create_customers(0)
  #     refute_received {:customer_created, _new_customer}
  #   end

  #   test "calls Customers.create/1 correct number of times" do
  #     assert :ok == Comprehension.create_customers(3)
  #     assert_received {:customer_created, _new_customer}
  #     assert_received {:customer_created, _new_customer}
  #     assert_received {:customer_created, _new_customer}
  #     refute_received {:customer_created, _new_customer}
  #   end
  # end

  # describe "order_total/1" do
  #   test "returns 0 for an empty list" do
  #     assert 0 == Comprehension.order_total([])
  #   end

  #   test "sums the total for all OrderItems in a list" do
  #     order_items = [
  #       %OrderItem{quantity: 2, item: %Item{name: "Item 1", price: 5.00}},
  #       %OrderItem{quantity: 1, item: %Item{name: "Item 2", price: 8.75}},
  #       %OrderItem{quantity: 3, item: %Item{name: "Item 3", price: 2.50}},
  #       %OrderItem{quantity: 10, item: %Item{name: "Item 4", price: 11.00}},
  #       %OrderItem{quantity: 0, item: %Item{name: "Item 5", price: 1.00}}
  #     ]
  #     assert 136.25 == Comprehension.order_total(order_items)
  #   end
  # end

  # describe "count_active/1" do
  #   test "returns 0 for empty list" do
  #     assert 0 == Comprehension.count_active([])
  #   end

  #   test "returns correct count of active customers" do
  #     customers = [
  #       %Customer{name: "Cust 1", active: true},
  #       %Customer{name: "Cust 2", active: true},
  #       %Customer{name: "Cust 3", active: false},
  #       %Customer{name: "Cust 4", active: true},
  #     ]
  #     assert 3 == Comprehension.count_active(customers)
  #   end
  # end
end
