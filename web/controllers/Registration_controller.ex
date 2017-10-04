defmodule Schooldata.RegistrationController do
    use Schooldata.Web, :controller
    
    alias Schooldata.User
    alias Schooldata.UserProfile

    plug Schooldata.Plugs.RequireAuth when action in [:profile]
    
    def new(conn, _params) do
        changeset = User.changeset(%User{}, %{})
        render conn, "new.html", changeset: changeset
    end

    def create(conn, %{"user" => user_params, "profile_type" => profile_type}) do
       #changeset = User.changeset(%User{}, user)
       changeset = %User{} |> User.registration_changeset(user_params)
       if profile_type == "0" do
          conn
            |> put_flash(:error, "Select Profile type")
            |> render("new.html", changeset: changeset)
       end

       case Repo.insert(changeset) do
        {:ok, user} ->
        
          profile = %{"uid" => user.id, "profile_type" => profile_type, "full_name" => user_params["name"]}
          profile_changeset = %UserProfile{} |> UserProfile.profile_changeset(profile)
        
          case Repo.insert(profile_changeset) do
           {:error, profile_changeset} ->
             conn
              |> put_flash(:info, "Unable to create account")
              |> render("new.html", changeset: changeset)
          end
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
        render(conn, "show.html", user: user, profile: user_profile) 
    end

end