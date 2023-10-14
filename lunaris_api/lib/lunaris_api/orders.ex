defmodule LunarisApi.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias LunarisApi.Repo

  alias LunarisApi.Orders.Order

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
   def create_order(order), do: Repo.insert(Order.changeset(%Order{}, order))
end
