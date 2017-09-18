defmodule Schooldata.Repo.Migrations.CreateUserProfile do
  use Ecto.Migration

  def change do
    create table(:user_profile) do
      add :full_name, :string
      add :roll_number, :string
      add :father_name, :string
      add :mother_name, :string
      add :address, :text
      add :mobile, :integer
      add :date_of_birth, :naive_datetime
      add :joining_date, :naive_datetime
      add :uid, references(:users)
      timestamps()
    end
  end
end
