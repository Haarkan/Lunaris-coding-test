defmodule LunarisApi.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :phone, :string
      add :balance, :float

      timestamps()
    end

    create unique_index(:customers, [:email])
    create unique_index(:customers, [:phone])
  end
end
