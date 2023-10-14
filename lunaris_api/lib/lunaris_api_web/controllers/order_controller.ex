defmodule LunarisApiWeb.OrderController do
  use LunarisApiWeb, :controller
  require Logger
  alias LunarisApi.Customers
  alias LunarisApi.Customers.Customer
  alias LunarisApi.Orders
  alias LunarisApi.Orders.Order

  action_fallback(LunarisApiWeb.FallbackController)

  def create_order(conn, %{
        "email" => email,
        "amount" => amount,
        "currency" => currency
      }) do
    customer = Customers.get_by_email(email)

    if customer == nil do
      conn
      |> put_status(:not_found)
      |> json(%{error: "Customer not found"})
    end

    order =
      %Order{customer_id: customer.id, amount: amount, currency: currency}

    conn
    |> put_status(:created)
    |> json(%{message: "Order processed successfully"})
  end
end
