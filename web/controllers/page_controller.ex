defmodule Schooldata.PageController do
  use Schooldata.Web, :controller
  
  def index(conn, _params) do
    render conn, "index.html"
  end
end
