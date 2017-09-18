defmodule Schooldata.UserRoles do
  use Schooldata.Web, :model

  use Ecto.Schema
  import Ecto.Changeset

  schema "user_roles" do
    field :uid, :integer
    field :rid, :integer
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> IO.inspect
    |> cast(params,[:uid, :rid])
  end
end
