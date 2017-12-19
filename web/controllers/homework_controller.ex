defmodule Schooldata.HomeworkController do
    use Schooldata.Web, :controller
    

    def index(conn, _params) do
     render conn, "homework.html"
    end

    
end