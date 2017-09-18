defmodule Schooldata.Classes do
    use Schooldata.Web, :model
    
    schema "classes" do
      field :name, :string
      has_one :user_profile, Schooldata.UserProfile
    end
    
end