defmodule LunarisApi.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias LunarisApi.Repo

  alias LunarisApi.Orders.Order

  @doc """
  Creates a order.
  """
   def create_order(order), do: Repo.insert(Order.changeset(%Order{}, order))
end
