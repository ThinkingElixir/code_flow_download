defmodule CodeFlow.Keywords do
  @moduledoc """
  Fix or complete the code to make the tests pass.
  """
  alias CodeFlow.Schemas.Item

  def rounded(value, opts \\ []) do
    decimals = Keyword.get(opts, :decimals, 4)
    Float.round(value, decimals)
  end

  def unit_price(%Item{} = item, opts \\ []) do
    raw_price = item.price / item.quantity
    case Keyword.get(opts, :mode, :float) do
      :float ->
        raw_price

      :money ->
        :erlang.float_to_binary(raw_price, decimals: 2)
    end
  end
end
