defmodule Schooldata.PaymentDetailsController do
    use Schooldata.Web, :controller
    
    #alias Schooldata.UserProfile
    #alias Schooldata.User
    plug Schooldata.Plugs.RequireAuth when action in [:index, :list]
    
    def index(conn, params) do
     # {payments, assigns} = PaymentsHelper.get_payment_types(conn, params)
      assigns = %{}
      payments = %{}
      assigns = Map.put(assigns, :url, payment_details_path(conn, :index))
      render conn, "paymentdetails.html" , filters: params, assigns: assigns, payments: payments
    end

    def list(conn, params) do
      {payments, assigns} = PaymentsHelper.get_payments_list(conn, params)
      payments_total = PaymentsHelper.get_payment_totals(conn, params)
     
      total = Enum.reduce(payments_total, 0, fn({total, _, _}, acc) -> Decimal.to_float(total) + acc end)
                 |> Decimal.new
                 |> Decimal.round
     
     
      assigns = Map.put(assigns, :url, payment_details_path(conn, :list))
      assigns = Map.put(assigns, :current_page, 1)
      assigns = Map.put(assigns, :per_page, 25)
      assigns = Map.put(assigns, :total, 3)
      render conn, "paymentslist.html" , assigns: assigns, 
                                         payments: payments, 
                                         filters: params, 
                                         total: payments_total, 
                                         grand_total: total
    end
end