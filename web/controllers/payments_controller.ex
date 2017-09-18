defmodule Schooldata.PaymentsController do
    use Schooldata.Web, :controller
    
    alias Schooldata.UserProfile
    alias Schooldata.User

    plug Schooldata.Plugs.RequireAuth when action in [:index, :new, :create]
   
    def index(conn, _params) do
     render conn, "payments.html"
    end

    def new(conn, _params) do
      changeset = User.changeset(%User{}, %{})
      render conn, "add_payments.html" , changeset: changeset
    end   

    def create(conn, params) do
      #IO.puts "++++++++++++"
      #IO.inspect(params)
      #IO.puts "+++++++++++"
      changeset = User.changeset(%User{}, %{})
      render conn, "add_payments.html" , changeset: changeset
    end   

end