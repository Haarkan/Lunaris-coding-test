defmodule LunarisApi.Customers do
  @moduledoc """
  The Customers context.
  """

  import Ecto.Query, warn: false
  alias LunarisApi.Repo

  alias LunarisApi.Customers.Customer

  def get_by_email(email), do: Repo.get_by(Customer, email: email)


  def reward_points(customer, points) do
    Repo.update(Customer.changeset(customer, %{balance: customer.balance + points}))
  end


  def create_customer(email, phone),
    do: Repo.insert(Customer.changeset(%Customer{}, %{email: email, phone: phone, balance: 0.0}))
end
