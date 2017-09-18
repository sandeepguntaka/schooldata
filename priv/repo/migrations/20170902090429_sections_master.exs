defmodule Schooldata.Repo.Migrations.SectionsMaster do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add :name, :string
    end

  execute "INSERT INTO sections(name) VALUES('A')"
  execute "INSERT INTO sections(name) VALUES('B')"
  execute "INSERT INTO sections(name) VALUES('C')"
  end
end
