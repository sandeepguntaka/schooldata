defmodule Schooldata.Repo.Migrations.UserPaymantDetailsTimestamps do
  use Ecto.Migration

  def change do
     alter table(:user_payments) do
       add :acadamic_year, :string
     end  
  end
end
