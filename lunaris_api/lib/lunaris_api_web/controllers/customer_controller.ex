defmodule LunarisApiWeb.CustomerController do
  use LunarisApiWeb, :controller

  alias LunarisApi.Customers
  alias LunarisApi.Customers.Customer

  action_fallback(LunarisApiWeb.FallbackController)

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
