defmodule Schooldata.Repo.Migrations.UserRoles do
  use Ecto.Migration

  def change do
    create table(:user_roles) do
      add :uid, references(:users)
      add :rid, references(:roles)
    end
  end
end
