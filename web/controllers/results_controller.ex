defmodule Schooldata.ResultsController do
    use Schooldata.Web, :controller

    def index(conn, _params) do
     render conn, "results.html"
    end

    
end