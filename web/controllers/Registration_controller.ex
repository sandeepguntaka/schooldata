defmodule Schooldata.RegistrationController do
    use Schooldata.Web, :controller
    
    alias Schooldata.User
    alias Schooldata.UserProfile

    plug Schooldata.Plugs.RequireAuth when action in [:new, :create, :profile]
    
    def new(conn, _params) do
        changeset = User.changeset(%User{}, %{})
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"user" => user_params}) do
       #changeset = User.changeset(%User{}, user)
       changeset = %User{} |> User.registration_changeset(user_params)
       
       case Repo.insert(changeset) do
        {:ok, user} ->
          conn
          |> put_flash(:info, "#{user.name} account  created!")
          |> redirect(to: "/")
        {:error, changeset} ->
          conn
          |> put_flash(:info, "Unable to create account")
          |> render("new.html", changeset: changeset)
      end
    end

    def profile(conn, %{"id" => id}) do
        user = Repo.get!(User, id)
        user_profile = Repo.get_by(UserProfile,[uid: id ])
        IO.inspect(user_profile)
        render(conn, "show.html", user: user, profile: user_profile) 
    end

end