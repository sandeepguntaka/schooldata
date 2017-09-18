defmodule Schooldata.Repo.Migrations.UserPayments do
  use Ecto.Migration

  def change do
    create table(:user_payments) do
      add :user_id, references(:users)
      add :payment_details_id, references(:payment_details)
      add :payment_date, :naive_datetime
      add :amount_paid, :decimal
      add :payment_mode, :string
      add :comment, :string
      add :received_id, references(:users)
      add :status, :string
    end
  end
end
