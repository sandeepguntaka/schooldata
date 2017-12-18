defmodule Schooldata.Section do
    use Schooldata.Web, :model
    
    use Ecto.Schema
    import Ecto.Changeset

    schema "sections" do
      field :name, :string
      has_one :user_profile, Schooldata.UserProfile
    end


    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:name])
      |> validate_required([:name])
    end
end