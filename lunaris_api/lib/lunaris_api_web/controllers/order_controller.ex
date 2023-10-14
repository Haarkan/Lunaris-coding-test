defmodule LunarisApiWeb.OrderController do
  @moduledoc """
  The controller for the orders
  """
  use LunarisApiWeb, :controller
  require Logger
  alias LunarisApi.Customers
  alias LunarisApi.Customers.Customer
  alias LunarisApi.Orders
  alias LunarisApi.Orders.Order

  action_fallback(LunarisApiWeb.FallbackController)

  @doc """
  Creates an order on POST /order
  Triggers reward function
  """
  def create_order(conn, %{
        "email" => email,
        "amount" => amount,
        "currency" => currency
      }) do

    case Customers.get_by_email(email) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Customer not found"})
      customer ->
        case Orders.create_order(%{customer_id: customer.id, amount: amount, currency: currency}) do
          {:ok, _} ->
            reward(customer, amount)
            conn
            |> put_status(:created)
            |> json(%{message: "Order created"})

          {:error, _} ->
            conn
            |> put_status(:internal_server_error)
            |> json(%{message: "Error while creating order"})
        end
    end

  end

  @doc """
  Rewards a customer with points calculated according to a percentage set in application config
  """
  defp reward(customer, price) do
    percentage = LunarisApi.PointPercentage.percentage()
    points = percentage / 100 * price
    Customers.change_balance(customer, points)
  end
end
