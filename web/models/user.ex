defmodule Schooldata.User do
  use Schooldata.Web, :model
  
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :hash_password, :string, virtual: true
    field :name, :string
    field :is_active, :boolean
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username,  :name, :password, :hash_password, :is_active])
    |> validate_required([:username , :name, :password, :hash_password])
    |> unique_constraint(:username)
    |> validate_password_confirmation
  end
  
  defp validate_password_confirmation(%{changes: changes} = changeset) do
    pwd = changes[:password]
    case changes[:hash_password] do
      ^pwd -> changeset
      _    -> add_error(changeset, :hash_password, "Password and Confirmation Password  must be similar!")
    end
  end



  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, [:password, :hash_password])
    |> validate_required([:password, :hash_password], message: "Are required")
    |> validate_length(:password, min: 6, max: 100)
    |> validate_confirmation(:hash_password, message: "Passwords must match")
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true,
                      changes: %{password: password}} ->
        put_change(changeset,
                   :password,
                   Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
