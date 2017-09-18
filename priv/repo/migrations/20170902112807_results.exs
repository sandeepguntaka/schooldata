defmodule Schooldata.Repo.Migrations.Results do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :uid, references(:users)
      add :exam_id, references(:examinations)
      add :marks_scored, :integer
      
      timestamps()

    end
  end
end
