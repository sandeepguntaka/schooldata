defmodule Schooldata.HomeworkController do
    use Schooldata.Web, :controller
    
    alias Schooldata.UserProfile
    alias Schooldata.User

    def index(conn, _params) do
     render conn, "homework.html"
    end

    
end