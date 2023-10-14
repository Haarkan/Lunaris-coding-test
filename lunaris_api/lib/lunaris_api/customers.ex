defmodule LunarisApi.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false
  alias LunarisApi.Repo

  alias LunarisApi.Customers.Customer

  @doc """
  Get a customer by its email.
  Returns an error if customere does not exist
  """
  def get_by_email(email), do: Repo.get_by(Customer, email: email)

  @doc """
  Get the balance of a customer by its email.
  Returns an error if customer does not exist
  """
  def get_balance_by_email(email) do
    from(c in Customer, where: c.email == ^email, select: c.balance)
    |> Repo.one()
  end

  @doc """
  Changes the balance of a customer.
  Returns an error if customer does not exist
  """
  def change_balance(customer, points) do
    Repo.update(Customer.changeset(customer, %{balance: customer.balance + points}))
  end

  @doc """
  Creates a new customer.
  Returns an error if email or phone are already used
  """
  def create_customer(email, phone),
    do: Repo.insert(Customer.changeset(%Customer{}, %{email: email, phone: phone, balance: 0.0}))
end
