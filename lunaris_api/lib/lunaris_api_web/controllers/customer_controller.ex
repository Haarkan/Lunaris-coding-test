defmodule LunarisApiWeb.CustomerController do
  use LunarisApiWeb, :controller

  alias LunarisApi.Customers
  alias LunarisApi.Customers.Customer

  action_fallback(LunarisApiWeb.FallbackController)

  def get_balance(conn, %{"email" => email}) do
    case Customers.get_balance_by_email(email) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Customer not found"})

      balance ->
        conn
        |> put_status(:ok)
        |> json(%{balance: balance})
    end
  end

  def create_customer(conn, %{
        "email" => email,
        "phone" => phone
      }) do

    Customers.create_customer(email, phone)
    |> case do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Customer created"})
      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{message: "User already exists "})
      end
  end

  @valid_actions ["add", "substract"]
  def change_balance(conn, %{"email" => email, "points" => points, "action" => action}) when action in @valid_actions do

    case Customers.get_by_email(email) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Customer not found"})

      customer ->
        adjusted_points =
          case {action, customer.balance < points} do
            {"substract", true} -> -customer.balance
            {"substract", false} -> -points
            {"add", _} -> points
          end

        case Customers.change_balance(customer, adjusted_points) do
          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> json(%{message: "Balance changed!"})

          {:error, _} ->
            conn
            |> put_status(:bad_request)
            |> json(%{message: "Error while changing balance"})
        end
    end
  end
end
