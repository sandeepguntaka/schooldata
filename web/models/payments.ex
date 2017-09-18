defmodule Schooldata.Payments do
    use Schooldata.Web, :model
    
    schema "payments" do
      field :payment_name, :string
    end    
end