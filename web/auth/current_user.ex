defmodule Schooldata.CurrentUser do
    import Plug.Conn
    import Guardian.Plug
  
    alias Schooldata.Repo
    alias Schooldata.User
    alias Schooldata.UserProfile

    def init(opts), do: opts
  
    def call(conn, _opts) do
      current_user = current_resource(conn)
      assign(conn, :current_user, current_user)
    end
  end