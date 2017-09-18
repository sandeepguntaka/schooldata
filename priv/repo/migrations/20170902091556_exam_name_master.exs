defmodule Schooldata.Repo.Migrations.ExamNameMaster do
  use Ecto.Migration

  def change do
    create table(:exam_names) do
      add :name, :string
    end

  execute "INSERT INTO exam_names(name) VALUES('Slip Test')"  
  execute "INSERT INTO exam_names(name) VALUES('Unit Test')"
  execute "INSERT INTO exam_names(name) VALUES('Quaterly')"
  execute "INSERT INTO exam_names(name) VALUES('Half Yearly')"
  execute "INSERT INTO exam_names(name) VALUES('Pre Final')"
  execute "INSERT INTO exam_names(name) VALUES('Annual')"
  end
end