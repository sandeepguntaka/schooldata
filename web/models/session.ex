defmodule Schooldata.Session do
    alias Schooldata.User

    def login(params, repo) do
        user = repo.get_by(User, username: String.downcase(params["username"]))
        case authenticate(user, params["password"]) do
            true -> {:ok, user}
            _ -> :error
        end
    end

    defp authenticate(user, password) do
        case user do
          nil -> false
          _   -> Comeonin.Bcrypt.checkpw(password, user.password)
        end
    end

    def current_user(conn) do
        id = Plug.Conn.get_session(conn, :user_id)
        if id, do: Schooldata.Repo.get(User, id)
    end

    def logged_in?(conn), do: !!current_user(conn)
end