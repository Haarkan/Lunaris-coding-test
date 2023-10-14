defmodule LunarisApi.CustomersTest do
  use LunarisApi.DataCase

  alias LunarisApi.Customers

  describe "customers" do
    alias LunarisApi.Customers.Customer

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_customer()

      customer
    end

    test "create_customer/2 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Customers.create_customer("email", "phone")
      assert customer.balance == 0
      assert customer.email == "email"
      assert customer.phone == "phone"
    end

    test "create_customer/2 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(nil, nil)
    end
  end
end
