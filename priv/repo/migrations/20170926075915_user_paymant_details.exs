defmodule Schooldata.Repo.Migrations.UserPaymantDetails do
  use Ecto.Migration

  def change do
     create table(:user_payment_details) do
      add :user_payments_id, references(:user_payments)
      add :payment_type_id, references(:payments)
      add :amount_paid, :decimal
      timestamps()
    end

    alter table(:user_payments) do
       remove :payment_details_id
       timestamps()
     end  

  end
end
