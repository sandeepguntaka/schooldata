defmodule Schooldata.SessionController do
    use Schooldata.Web, :controller
    import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

    alias Schooldata.User

    plug :scrub_params, "session" when action in ~w(create)a
    
    def new(conn, _params) do
        render conn, "new.html"
    end

    def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
        user = Repo.get_by(User, username: username)
        
        result = cond do
            user && checkpw(password, user.password) ->
                {:ok, login(conn, user)}
            user ->
                {:error, :unauthorized, conn}
            true ->
                dummy_checkpw
                {:error, :not_found, conn}
        end

        case result do
            {:ok, conn} ->
                conn
                |> put_flash(:info, "You’re now logged in!")
                |> redirect(to: page_path(conn, :index))
            {:error, _reason, conn} ->
                conn
                |> put_flash(:error, "Invalid email/password combination")
                |> render("new.html")
        end
    end

    defp login(conn, user) do
        conn
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: registration_path(conn, :profile, user.id))
    end

    def delete(conn, _params) do
        conn
        |> logout
        |> put_flash(:info, "See you later!")
        |> redirect(to: page_path(conn, :index))
    end

    defp logout(conn) do
        Guardian.Plug.sign_out(conn)
    end
end