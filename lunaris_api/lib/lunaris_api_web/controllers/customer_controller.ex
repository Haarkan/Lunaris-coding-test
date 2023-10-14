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
      {:error, _} ->
        conn
        |> put_status(:internal_server_error)
        |> json(%{message: "Error while create user"})
      end
  end
end
