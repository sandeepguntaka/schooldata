defmodule Schooldata.Repo.Migrations.StudentProfileAlterClass do
  use Ecto.Migration

  def change do
    alter table(:student_profile) do
      remove :class_id  
    end  
    
    alter table(:student_profile) do
      add :class_id, :integer  
    end  
  
  end
end
