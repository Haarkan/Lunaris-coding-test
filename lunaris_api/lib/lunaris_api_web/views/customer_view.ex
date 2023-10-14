defmodule LunarisApiWeb.CustomerView do
  use LunarisApiWeb, :view
  alias LunarisApiWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      email: customer.email,
      phone: customer.phone,
      balance: customer.balance}
  end
end
