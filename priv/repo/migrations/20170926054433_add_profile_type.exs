defmodule Schooldata.Repo.Migrations.AddProfileType do
  use Ecto.Migration

  def change do
    alter table(:user_profile) do
       add :profile_type, :string
     end
  end
end
