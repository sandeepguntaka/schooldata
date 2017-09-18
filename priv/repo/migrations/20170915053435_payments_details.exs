defmodule Schooldata.Repo.Migrations.PaymentsDetails do
  use Ecto.Migration

  def change do
    create table(:payment_details) do
      add :payment_id, references(:payments)
      add :class_id, references(:classes)
      add :amount, :decimal
      add :acadamic_year, :string
      add :distance, :decimal
      add :installments, :integer
    end
  end
end
