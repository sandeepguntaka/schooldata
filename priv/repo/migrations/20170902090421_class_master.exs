defmodule Schooldata.Repo.Migrations.ClassMaster do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string
    end

  execute "INSERT INTO classes(name) VALUES('Nursery')"
  execute "INSERT INTO classes(name) VALUES('LKG')"
  execute "INSERT INTO classes(name) VALUES('UKG')"
  execute "INSERT INTO classes(name) VALUES('Std I')"
  execute "INSERT INTO classes(name) VALUES('Std II')"
  execute "INSERT INTO classes(name) VALUES('Std III')"
  execute "INSERT INTO classes(name) VALUES('Std IV')"
  execute "INSERT INTO classes(name) VALUES('Std V')"
  execute "INSERT INTO classes(name) VALUES('Std VI')"
  execute "INSERT INTO classes(name) VALUES('Std VII')"
  execute "INSERT INTO classes(name) VALUES('Std VIII')"
  execute "INSERT INTO classes(name) VALUES('Std IX')"
  execute "INSERT INTO classes(name) VALUES('Std X')"
  end
end