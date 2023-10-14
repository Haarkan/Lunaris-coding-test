defmodule LunarisApiWeb.CustomerControllerTest do
  use LunarisApiWeb.ConnCase
  alias LunarisApi.Customers

  # Test for GET /customer to fetch customer balance
  test "GET /customer fetch customer balance for an existing customer", %{conn: conn} do
    # GIVEN
    new_email = "new@example.com"
    new_phone = "111-222-3333"
    expected_body = "{\"balance\":0.0}"
    Customers.create_customer(new_email, new_phone)

    # WHEN
    conn = get(conn, Routes.customer_path(conn, :get_balance, new_email))

    # THEN
    assert conn.status == 200
    assert conn.resp_body == expected_body
  end

   # Test for GET /customer to fetch customer balance
   test "GET /customer fetch customer balance for a non existing customer", %{conn: conn} do
    # GIVEN
    unknown_email = "unknown@example.com"
    # WHEN
    conn = get(conn, Routes.customer_path(conn, :get_balance, unknown_email))
    # THEN
    assert conn.status == 404
  end

   # Test for POST /customer to create a customer
  test "POST /customer create customer", %{conn: conn} do
    # GIVEN
    new_email = "new@example.com"
    new_phone = "111-222-3333"
    params = %{"email" => new_phone, "phone" => new_phone}

    # WHEN
    conn = post(conn, Routes.customer_path(conn, :create_customer), params)

    # THEN
    assert conn.status == 201
    assert conn.resp_body == "{\"message\":\"Customer created\"}"
  end

  test "POST /customer create customer with an existing email", %{conn: conn} do
    # GIVEN
    existing_email = "existing@example.com"
    existing_phone = "111-222-3333"
    new_phone = "123-456-7890"
    Customers.create_customer(existing_email, existing_phone)

    # WHEN
    params = %{"email" => existing_email, "phone" => existing_phone}
    conn = post(conn, Routes.customer_path(conn, :create_customer), params)

    # THEN
    assert conn.status == 400
  end

  test "POST /customer create customer with an existing phone", %{conn: conn} do
    # GIVEN
    existing_email = "example@example.com"
    existing_phone = "123-456-7890"
    new_email = "new@example.com"
    Customers.create_customer(existing_email, existing_phone)

    # WHEN
    params = %{"email" => new_email, "phone" => existing_phone}
    conn = post(conn, Routes.customer_path(conn, :create_customer), params)

    # THEN
    assert conn.status == 400
  end

  test "POST /customer change balance for an existing customer", %{conn: conn} do
    # GIVEN
    email = "test@example.com"
    phone = "123-456-7890"
    points_to_add = 50.0
    expected_points = 50.0
    action = "add"
    Customers.create_customer(email, phone)

    # WHEN
    params = %{"email" => email, "points" => points_to_add, "action" => action}

    conn = put(conn, Routes.customer_path(conn, :change_balance), params)

    # THEN
    assert conn.status == 200
    balance = Customers.get_balance_by_email(email)
    assert balance == expected_points
  end

  test "POST /customer subtract balance for an existing customer", %{conn: conn} do
    # GIVEN
    email = "test@example.com"
    phone = "123-456-7890"
    points_to_add = 50.0
    expected_points = 250.0
    current_balance = 300.0
    action = "subtract"
    Customers.create_customer(email, phone)
    customer = Customers.get_by_email(email)
    Customers.change_balance(customer, current_balance)
    # WHEN
    params = %{"email" => email, "points" => points_to_add, "action" => action}

    conn = put(conn, Routes.customer_path(conn, :change_balance), params)

    # THEN
    assert conn.status == 200
    balance = Customers.get_balance_by_email(email)
    assert balance == expected_points
  end

  test "POST /customer subtract balance for an existing customer should be not go bellow 0", %{conn: conn} do
    # GIVEN
    email = "test@example.com"
    phone = "123-456-7890"
    current_balance = 300.0
    points_to_subtract = 350.0
    expected_points = 0
    action = "subtract"
    Customers.create_customer(email, phone)
    customer = Customers.get_by_email(email)
    Customers.change_balance(customer, current_balance)
    # WHEN
    params = %{"email" => email, "points" => points_to_subtract, "action" => action}

    conn = put(conn, Routes.customer_path(conn, :change_balance), params)

    # THEN
    assert conn.status == 200
    balance = Customers.get_balance_by_email(email)
    assert balance == expected_points
  end

  test "POST /customer add balance for non-existing customer", %{conn: conn} do
    # GIVEN
    nonexistent_email = "nonexistent@example.com"
    params = %{"email" => nonexistent_email, "points" => 50, "action" => "add"}

    # WHEN
    conn = put(conn, Routes.customer_path(conn, :change_balance), params)

    # THEN
    assert conn.status == 404
  end
end
