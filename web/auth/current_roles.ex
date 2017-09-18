defmodule Schooldata.CurrentRoles do
    import Plug.Conn
    import Guardian.Plug
  
    alias Schooldata.Repo

    def init(opts), do: opts
  
    def call(conn, _opts) do
      current_user = current_resource(conn)
      current_roles = Helper.logged_in_roles(current_user)
      assign(conn, :roles, current_roles)
    end
  end