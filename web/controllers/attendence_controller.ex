defmodule Schooldata.AttendenceController do
    use Schooldata.Web, :controller
    

    def index(conn, _params) do
     render conn, "attendence.html"
    end

    
end