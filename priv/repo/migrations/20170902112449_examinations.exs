defmodule Schooldata.Repo.Migrations.Examinations do
  use Ecto.Migration

  def change do
    create table(:examinations) do
      add :class_id, references(:classes)
      add :section_id, references(:sections)
      add :sub_id, references(:subjects)
      add :total_marks, :integer
      add :exam_date, :naive_datetime
      add :passing_marks, :integer
    end
  end
end
