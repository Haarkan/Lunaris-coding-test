defmodule LunarisApi.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :currency, :string
    field :amount, :float
    field :customer_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:amount, :currency])
    |> validate_required([:amount, :currency])
  end
end
