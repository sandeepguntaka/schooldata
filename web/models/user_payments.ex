defmodule Schooldata.UserPayments do
    use Schooldata.Web, :model
    
    schema "user_payments" do
      belongs_to :user, Schooldata.User
      belongs_to :payment_details, Schooldata.PaymentDetails
      field :amount_paid, :decimal
      field :payment_date, :utc_datetime
      field :payment_mode, :string
      field :comment, :string
      belongs_to :received, Schooldata.User
      field :status, :string
    end 
end