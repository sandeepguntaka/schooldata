defmodule Schooldata.Repo.Migrations.User do
  use Ecto.Migration

  def change do
    create table (:users) do
      add :name, :string
      add :username, :string
      add :password, :string
      add :is_active, :boolean, default: true 
      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
