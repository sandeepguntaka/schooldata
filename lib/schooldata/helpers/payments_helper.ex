defmodule PaymentsHelper do
    alias Schooldata.Repo
    #import Plug.Conn
    import Ecto.Query 

    alias Schooldata.PaymentDetails
    alias Schooldata.Classes
    alias Schooldata.Payments
  
    def get_payment_types(_conn, data \\ %{}) do
      query = from(pd in PaymentDetails, 
                   join: cs in Classes, on: pd.class_id == cs.id,
                   join: p in Payments, on: p.id == pd.payment_id,
                   select: %{id: pd.id, class_id: cs.id,  class_name: cs.name, fee_name: p.payment_name,
                            amount: pd.amount, acadamic_year: pd.acadamic_year, 
                            distance: pd.distance, installments: pd.installments}
                  )

    query = if data["class_id"] && data["class_id"] != "0" do
      from(q in query, where: q.class_id == ^String.to_integer(data["class_id"]))
      else query
    end

      payments = Repo.all(query)    
      params = %{current_page: data["page"], total: 30, per_page: 10}
      {payments,  params}
    end

 
end