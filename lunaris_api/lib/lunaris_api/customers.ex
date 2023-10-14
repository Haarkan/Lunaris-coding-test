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
  ## Examples

      iex> get_by_email(%{email: value})
      {:ok, %Customer{}}

      iex> get_by_email(%{email: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def get_by_email(email), do: Repo.get_by(Customer, email: email)

  @doc """
  Get the balance of a customer by its email.
  Returns an error if customere does not exist
  ## Examples

      iex> get_balance_by_email(%{email: value})
      {:ok, %Customer{}}

      iex> get_balance_by_email(%{email: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def get_balance_by_email(email) do
    from(c in Customer, where: c.email == ^email, select: c.balance)
    |> Repo.one()
  end

  def change_balance(customer, points) do
    Repo.update(Customer.changeset(customer, %{balance: customer.balance + points}))
  end

  def create_customer(email, phone),
    do: Repo.insert(Customer.changeset(%Customer{}, %{email: email, phone: phone, balance: 0.0}))
end
