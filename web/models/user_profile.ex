defmodule Schooldata.UserProfile do
  use Schooldata.Web, :model

  use Ecto.Schema
  import Ecto.Changeset

  schema "user_profile" do
    field :full_name, :string
    field :roll_number, :string
    field :father_name, :string
    field :mother_name, :string
    field :address, :string
    field :mobile, :integer
    field :date_of_birth, :utc_datetime
    field :joining_date, :utc_datetime
    field :uid, :integer
     #belongs_to :user, Schooldata.User
    belongs_to :class, Schooldata.Classes
    belongs_to :section, Schooldata.Sections
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> IO.inspect
    |> cast(params,
              [:full_name, :roll_number, 
               :father_name, :mother_name, 
               :address, :mobile, :date_of_birth, :joining_date, :uid, 
               :class_id, :section_id])
    |> validate_required([:full_name, :roll_number, :father_name, :mother_name, 
                          :mobile, :date_of_birth, :joining_date])
  end
end
