defmodule Schooldata.Repo.Migrations.StudentProfile do
  use Ecto.Migration

  def change do
    create table(:student_profile) do
      add :first_name, :string
      add :last_name, :string
      add :roll_number, :string
      add :class_id, :string
      add :gender, :string
      add :medium, :string
      add :date_of_birth, :naive_datetime
      add :place_of_birth, :string
      add :blood_group, :string
      add :nationality, :string
      add :religion, :string
      add :caste, :string
      add :mother_tounge, :string
      add :id_mark_1, :string
      add :id_mark_2, :string
      add :aadhar, :string
      add :passport, :string
      add :house_no, :string
      add :colony, :string
      add :city, :string
      add :state, :string
      add :pincode, :string
      add :mobile, :string
      add :email, :string
      add :student_living_with, :string
      add :mother_name, :string
      add :mother_qualification, :string
      add :mother_profession, :string
      add :mother_working_organization, :string
      add :mother_mobile, :string
      add :mother_email, :string
      add :father_name, :string
      add :father_qualification, :string
      add :father_profession, :string
      add :father_working_organization, :string
      add :father_mobile, :string
      add :father_email, :string
      add :gardian_name, :string
      add :gardian_qualification, :string
      add :gardian_profession, :string
      add :gardian_working_organization, :string
      add :gardian_mobile, :string
      add :gardian_email, :string
      add :tc_submitted, :integer
      add :admission_status, :string
      add :conduct_certificate_submitted, :integer
      add :uid, references(:users)
      
      timestamps()
    end
  end
end
