defmodule LunarisApiWeb.OrderControllerTest do
  use LunarisApiWeb.ConnCase
  alias LunarisApi.Customers

  setup do
    # Insert a customer record into the test database
    customer = insert_customer("customer@example.com", "123-456-7890")

    {:ok, customer: customer}
  end

  defp insert_customer(email, phone) do
    Customers.create_customer(email,  phone)
  end

  test "POST /order create order for an existing customer", %{conn: conn} do
    # GIVEN
    params = %{
      "email" => "customer@example.com",
      "amount" => 100.0,
      "currency" => "JPY"
    }
    expected_balance = 1.0

    # WHEN
    conn = post(conn, Routes.order_path(conn, :create_order), params)

    # THEN
    assert conn.status == 201
    updated_customer = Customers.get_by_email("customer@example.com")
    assert updated_customer.balance == expected_balance
  end

  # Test for POST /order create order for a non-existing customer
  test "POST /order create order for a non-existing customer", %{conn: conn} do
    # GIVEN
    params = %{
      "email" => "nonexistent@example.com",
      "amount" => 100.0,
      "currency" => "JPY"
    }

    # WHEN
    conn = post(conn, Routes.order_path(conn, :create_order), params)

    # THEN
    assert conn.status == 404
  end
end
