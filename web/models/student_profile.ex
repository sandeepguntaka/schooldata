defmodule Schooldata.StudentProfile do
  use Schooldata.Web, :model

  use Ecto.Schema
  import Ecto.Changeset

  schema "student_profile" do
    field :first_name, :string
    field :last_name, :string
    field :roll_number, :string
    field :gender, :string
    field :medium, :string
    field :date_of_birth, :naive_datetime
    field :place_of_birth, :string
    field :blood_group, :string
    field :nationality, :string
    field :religion, :string
    field :caste, :string
    field :mother_tounge, :string
    field :id_mark_1, :string
    field :id_mark_2, :string
    field :aadhar, :string
    field :passport, :string
    field :house_no, :string
    field :colony, :string
    field :city, :string
    field :state, :string
    field :pincode, :string
    field :mobile, :string
    field :email, :string
    field :student_living_with, :string
    field :mother_name, :string
    field :mother_qualification, :string
    field :mother_profession, :string
    field :mother_working_organization, :string
    field :mother_mobile, :string
    field :mother_email, :string
    field :father_name, :string
    field :father_qualification, :string
    field :father_profession, :string
    field :father_working_organization, :string
    field :father_mobile, :string
    field :father_email, :string
    field :gardian_name, :string
    field :gardian_qualification, :string
    field :gardian_profession, :string
    field :gardian_working_organization, :string
    field :gardian_mobile, :string
    field :gardian_email, :string
    field :tc_submitted, :integer
    field :admission_status, :string
    field :conduct_certificate_submitted, :integer
    field :uid, :integer
     #belongs_to :user, Schooldata.User
    belongs_to :class, Schooldata.Classes

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params,
              [:first_name, :last_name, :roll_number, :gender, :medium, :date_of_birth, 
               :place_of_birth, :blood_group, :nationality, :caste, :religion, :mother_tounge, :id_mark_1, :id_mark_2,
               :aadhar, :passport, :house_no, :colony, :city, :state, :pincode, :mobile,
               :email, :student_living_with, :mother_name, :mother_profession,
               :mother_qualification, :mother_working_organization, :mother_email,
               :mother_mobile,:father_name, :father_profession, :father_qualification,
               :father_working_organization, :father_mobile, :father_email,
               :gardian_name, :gardian_profession, :gardian_qualification, 
               :gardian_working_organization, :gardian_working_organization, :gardian_mobile, 
               :gardian_email, :tc_submitted, :conduct_certificate_submitted, :admission_status,
               :uid, :class_id])
    |> validate_required([:first_name, :last_name, :gender, :class_id, :date_of_birth])
  end

end
