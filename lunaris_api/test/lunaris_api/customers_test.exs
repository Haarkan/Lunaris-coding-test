defmodule LunarisApi.CustomersTest do
  use LunarisApi.DataCase

  alias LunarisApi.Customers

  describe "customers" do
    alias LunarisApi.Customers.Customer

    test "get_by_email/1 returns nil if customer does not exist" do
      assert is_nil(Customers.get_by_email("nonexistent@example.com"))
    end

    test "get_balance_by_email/1 returns nil if customer does not exist" do
      assert is_nil(Customers.get_balance_by_email("nonexistent@example.com"))
    end

    test "create_customer/2 creates a new customer" do
      email = "newcustomer@example.com"
      phone = "123-456-7890"

      assert {:ok, _} = Customers.create_customer(email, phone)
    end

    test "create_customer/2 returns an error if email is already used" do
      email = "existing@example.com"
      phone = "123-456-7890"

      {:ok, _} = Customers.create_customer(email, phone)

      assert {:error, _} = Customers.create_customer(email, "987-654-3210")
    end

    test "create_customer/2 returns an error if phone is already used" do
      email = "newcustomer@example.com"
      phone = "987-654-3210"

      {:ok, _} = Customers.create_customer(email, phone)

      assert {:error, _} = Customers.create_customer("another@example.com", phone)
    end
  end
end
