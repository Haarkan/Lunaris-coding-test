defmodule LunarisApi.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "customers" do
    field(:balance, :float)
    field(:email, :string)
    field(:phone, :string)

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :phone, :balance])
    |> validate_required([:email, :phone, :balance])
    |> unique_constraint(:email)
    |> unique_constraint(:phone)
  end
end
