defmodule Schooldata.PaymentDetailsController do
    use Schooldata.Web, :controller
    
    #alias Schooldata.UserProfile
    #alias Schooldata.User
    plug Schooldata.Plugs.RequireAuth when action in [:index, :list]
    
    def index(conn, params) do
      {payments, assigns} = PaymentsHelper.get_payment_types(conn, params)
      assigns = Map.put(assigns, :url, payment_details_path(conn, :index))
      render conn, "paymentdetails.html" , assigns: assigns, payments: payments, filters: params
    end

    def list(conn, params) do
      {payments, assigns} = PaymentsHelper.get_payment_types(conn, params)
      assigns = Map.put(assigns, :url, payment_details_path(conn, :list))
      render conn, "paymentslist.html" , assigns: assigns, payments: payments, filters: params
    end
end