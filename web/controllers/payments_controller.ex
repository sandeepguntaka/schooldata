defmodule Schooldata.PaymentsController do
    use Schooldata.Web, :controller
    
    alias Schooldata.UserProfile
    alias Schooldata.User
    alias Schooldata.UserPayments
    alias Schooldata.UserPaymentsDetails


    plug Schooldata.Plugs.RequireAuth when action in [:index, :new, :create]
   
    def index(conn, _params) do
     render conn, "payments.html"
    end

    def show(conn, params) do 
      {payments, payments_list} = PaymentsHelper.load_payment_details(params["id"])
      if payments == nil do
         render conn, "display_payment.html" , noresult: 1
      else
        user = Helper.load_user_details(payments.user_id)
        received = Helper.load_user_details(payments.received_id)
        total = Enum.reduce(payments_list, 0, fn({ _, payment}, acc) -> acc+Decimal.to_float(payment.amount_paid)  end) 
          |> Decimal.new
          |> Decimal.round(2)

        words = total |> Decimal.to_integer |> NumberToWord.say
        render conn, "display_payment.html" , user: user, payments: payments, list: payments_list, total: total, received: received, noresult: 2, words: words
      end
    end

    def new(conn, _params) do
      changeset = User.changeset(%User{}, %{})
      render conn, "add_payments.html" , changeset: changeset
    end   

    def create(conn, params) do
      {payments, payments_sel} = preapre_payments(conn.assigns.current_user.id, params)
       
      payments = Enum.filter(payments, fn {_, value} -> not(value in ["0", 0]) end) |> Map.new 
      payments = UserPayments.changeset(%UserPayments{}, payments)

      case Repo.insert(payments) do
        {:ok, payment} ->
        Enum.map(payments_sel, fn {type, amount} ->
          payments_list = UserPaymentsDetails.changeset(%UserPaymentsDetails{},
              %{"user_payments_id" => payment.id, 
                "payment_type_id" => type,
                "amount_paid" => String.to_integer(amount)
                })
            Repo.insert(payments_list)
          end)
        conn
            |> put_flash(:info, " Payment Successfully Done!")
            |> redirect(to: "/payments/#{payment.id}")
        {:error, changeset} ->
          conn
          |> put_flash(:info, "Unable to make payment. Try again with proper inputs")
          |> render("add_payments.html", changeset: changeset)
      end
    end   

    def preapre_payments(current_user, params) do     
      %{"amount" => amounts,  "comment" => comment,
          "user_id" => user,  "payment_id" => payments,
          "acadamic_year" => acadamic_year, "payment_mode" => payment_mode
      } = params

      amounts = Enum.filter(amounts, fn {_, value} ->  Integer.parse(value) != :error end) |> Map.new
      payments_sel = payments_selected(amounts, payments)
      total_amount = Enum.reduce(payments_sel, 0, fn({key, val}, acc) -> String.to_integer(val) + acc end)    
      today_date = NaiveDateTime.utc_now
      
      all_payments = %{"payment_mode" => payment_mode, "user_id" => user,
                 "payment_date" => today_date,  "amount_paid" => total_amount,
                 "comment" => comment,  "received_id" => current_user,
                 "status" => "closed",  "inserted_at" => today_date,
                 "acadamic_year" => acadamic_year
      }
      {all_payments, payments_sel}
    end

    def payments_selected(amounts, payments) do
      payments = Enum.reduce(payments, %{}, fn({key, val}, acc) ->
         val = if val != "0" and not(amounts[key] in ["", nil]) do  
           Map.update(acc, String.to_integer(val), amounts[key], fn(prev_val) -> 
             Integer.to_string(String.to_integer("#{amounts[key]}") + String.to_integer("#{prev_val}"))     
           end)
         else 
           acc
         end       
       end)
    end
end