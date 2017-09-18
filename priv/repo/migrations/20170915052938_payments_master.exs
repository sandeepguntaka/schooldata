defmodule Schooldata.Repo.Migrations.PaymentsMaster do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :payment_name, :string
    end

   execute "INSERT INTO payments(payment_name) VALUES('Admission Fee')"
   execute "INSERT INTO payments(payment_name) VALUES('Term')"
   execute "INSERT INTO payments(payment_name) VALUES('Monthly')"
   execute "INSERT INTO payments(payment_name) VALUES('Examination')"
   execute "INSERT INTO payments(payment_name) VALUES('Transport')"
   execute "INSERT INTO payments(payment_name) VALUES('Development')"
   execute "INSERT INTO payments(payment_name) VALUES('Lab')"
   execute "INSERT INTO payments(payment_name) VALUES('Books')"
   execute "INSERT INTO payments(payment_name) VALUES('Excursion')"
   execute "INSERT INTO payments(payment_name) VALUES('Cultural Activity')"
   execute "INSERT INTO payments(payment_name) VALUES('Uniform')"
   execute "INSERT INTO payments(payment_name) VALUES('Gadgets')"
   execute "INSERT INTO payments(payment_name) VALUES('Records')"
   execute "INSERT INTO payments(payment_name) VALUES('Project')"
  end
end
