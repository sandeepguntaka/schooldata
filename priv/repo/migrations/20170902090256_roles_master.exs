defmodule Schooldata.Repo.Migrations.RolesMaster do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :role_name, :string
    end

   execute "INSERT INTO roles(role_name) VALUES('Director')"
   execute "INSERT INTO roles(role_name) VALUES('Principal')"
   execute "INSERT INTO roles(role_name) VALUES('Class Teacher')"
   execute "INSERT INTO roles(role_name) VALUES('Teacher')"
   execute "INSERT INTO roles(role_name) VALUES('Class Representative')"
   execute "INSERT INTO roles(role_name) VALUES('Student')"
  end
end
