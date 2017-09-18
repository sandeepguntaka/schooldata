defmodule Schooldata.Repo.Migrations.UpdateUserTableReferences do
  use Ecto.Migration

  def change do
    alter table(:user_profile) do
      add :class_id, references(:classes)
      add :section_id, references(:sections)
      add :role_id, references(:roles)
    end

    execute "INSERT INTO roles(role_name) VALUES('Director')"
    execute "INSERT INTO roles(role_name) VALUES('Principal')"
    execute "INSERT INTO roles(role_name) VALUES('Class Teacher')"
    execute "INSERT INTO roles(role_name) VALUES('Teacher')"
    execute "INSERT INTO roles(role_name) VALUES('Class Representative')"
    execute "INSERT INTO roles(role_name) VALUES('Student')"
  end
end
