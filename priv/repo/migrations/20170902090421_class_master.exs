defmodule Schooldata.Repo.Migrations.ClassMaster do
  use Ecto.Migration

  def change do
    create table(:classes) do
      add :name, :string
    end

  execute "INSERT INTO classes(name) VALUES('Nursery')"
  execute "INSERT INTO classes(name) VALUES('LKG')"
  execute "INSERT INTO classes(name) VALUES('UKG')"
  execute "INSERT INTO classes(name) VALUES('1')"
  execute "INSERT INTO classes(name) VALUES('2')"
  execute "INSERT INTO classes(name) VALUES('3')"
  execute "INSERT INTO classes(name) VALUES('4')"
  execute "INSERT INTO classes(name) VALUES('5')"
  execute "INSERT INTO classes(name) VALUES('6')"
  execute "INSERT INTO classes(name) VALUES('7')"
  execute "INSERT INTO classes(name) VALUES('8')"
  execute "INSERT INTO classes(name) VALUES('9')"
  execute "INSERT INTO classes(name) VALUES('10')"
  end
end