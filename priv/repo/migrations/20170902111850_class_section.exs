defmodule Schooldata.Repo.Migrations.ClassSection do
  use Ecto.Migration

  def change do
    create table(:class_section) do
      add :class_id, references(:classes)
      add :section_id, references(:sections)
    end
  end
end
