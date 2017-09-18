defmodule Schooldata.PaymentDetails do
    use Schooldata.Web, :model
    
    schema "payment_details" do
      belongs_to :payment, Schooldata.Payments
      belongs_to :class, Schooldata.Classes
      field :amount, :decimal
      field :acadamic_year, :string
      field :distance, :decimal
      field :installments, :integer
    end 
end