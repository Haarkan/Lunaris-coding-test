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

    Orders.create_order(%{customer_id: customer.id, amount: amount, currency: currency})
    |> case do
      {:ok, _} ->
        reward(customer, amount)
        conn
        |> put_status(:created)
        |> json(%{message: "Order created"})
      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{message: "Error while create user"})
      end
  end

  def reward(customer, price) do
    points = price * 0.01
    Customers.reward_points(customer, points)
  end
end
