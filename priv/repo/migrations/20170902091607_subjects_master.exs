defmodule Schooldata.Repo.Migrations.SubjectsMaster do
  use Ecto.Migration

  def change do
    create table(:subjects) do
      add :name, :string
    end

  execute "INSERT INTO subjects(name) VALUES('Telugu')"
  execute "INSERT INTO subjects(name) VALUES('Hindi')"
  execute "INSERT INTO subjects(name) VALUES('English')"
  execute "INSERT INTO subjects(name) VALUES('Mathamatics')"
  execute "INSERT INTO subjects(name) VALUES('Science')"
  execute "INSERT INTO subjects(name) VALUES('Social')"
  execute "INSERT INTO subjects(name) VALUES('GK')"
  execute "INSERT INTO subjects(name) VALUES('Moral Science')"
  execute "INSERT INTO subjects(name) VALUES('Computer')"
  
  end
end
