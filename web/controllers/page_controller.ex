defmodule Schooldata.PageController do
  use Schooldata.Web, :controller
  
  def index(conn, _params) do
    if conn.assigns.current_user != nil do
      conn
       |> redirect(to: "/payments")
    else  
     render conn, "index.html"
    end 
  end
end
