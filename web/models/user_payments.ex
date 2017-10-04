defmodule Schooldata.UserPayments do
    use Schooldata.Web, :model
    
    schema "user_payments" do
      belongs_to :user, Schooldata.User
      field :amount_paid, :decimal
      field :payment_date, :utc_datetime
      field :payment_mode, :string
      field :comment, :string
      belongs_to :received, Schooldata.User
      field :status, :string
      field :acadamic_year, :string
      timestamps()
    end 

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :amount_paid, :payment_date, :payment_mode,
                     :comment, :status, :received_id, :acadamic_year])
    |> validate_required([:amount_paid, :payment_mode, :user_id])
  end

end