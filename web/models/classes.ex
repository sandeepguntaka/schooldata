defmodule Schooldata.Classes do
    use Schooldata.Web, :model

    import Ecto.Query

    schema "classes" do
      field :name, :string
    end
    
end