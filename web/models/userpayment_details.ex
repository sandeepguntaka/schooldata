defmodule Schooldata.UserPaymentsDetails do
    use Schooldata.Web, :model
    
    schema "user_payment_details" do
      belongs_to :user_payments, Schooldata.UserPayments
      belongs_to :payment_type, Schooldata.Payments
      field :amount_paid, :decimal
      timestamps()
    end 


  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_payments_id,  :payment_type_id, :amount_paid])
    |> validate_required([:payment_type_id, :user_payments_id, :amount_paid])
    |> foreign_key_constraint(:payment_type_id)
  end
  
end