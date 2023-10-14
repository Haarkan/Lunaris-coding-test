defmodule LunarisApi.OrdersTest do
  use LunarisApi.DataCase

  alias LunarisApi.Orders

  describe "orders" do
    alias LunarisApi.Orders.Order

    @valid_attrs %{currency: "some currency", amount: 120.5}
    @update_attrs %{currency: "some updated currency", amount: 456.7}
    @invalid_attrs %{currency: nil, amount: nil}

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Orders.create_order(@valid_attrs)
      assert order.currency == "some currency"
      assert order.amount == 120.5
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end
  end
end
