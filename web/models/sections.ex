defmodule Schooldata.Sections do
    use Schooldata.Web, :model
    
    use Ecto.Schema
    import Ecto.Changeset

    schema "sections" do
      field :name, :string
      has_one :user_profile, Schooldata.UserProfile
    end
    
end