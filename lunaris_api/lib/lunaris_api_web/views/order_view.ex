defmodule LunarisApiWeb.OrderView do
  use LunarisApiWeb, :view
  alias LunarisApiWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      currency: order.currency,
      amount: order.amount}
  end
end
