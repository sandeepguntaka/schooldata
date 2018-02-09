defmodule Schooldata.ComplaintsController do
    use Schooldata.Web, :controller
    

    def index(conn, _params) do
     render conn, "complaints.html"
    end

    
end