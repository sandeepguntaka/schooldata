defmodule PaymentsHelper do
    alias Schooldata.Repo
    #import Plug.Conn
    import Ecto.Query 

    alias Schooldata.UserProfile
    alias Schooldata.Classes
    alias Schooldata.Payments
    alias Schooldata.UserPayments
    alias Schooldata.UserPaymentsDetails
  
    def load_payment_details(id) do
      payments = Repo.get(UserPayments, id)
      if payments == nil do
       {}
      end
      query = from(upd in UserPaymentsDetails, left_join: p in Payments, on: p.id == upd.payment_type_id,
      select: {p, upd}, where: [user_payments_id: ^id])
      payments_list = Repo.all(query)
      
      {payments, payments_list} 
    end

    def get_payment_types(_conn, _ \\ %{}) do
      {}
    end

    def get_payments_list(_conn, data \\ %{}) do
      query = from(upy in UserPayments, 
                   left_join: upyd in UserPaymentsDetails, on: upy.id == upyd.user_payments_id,
                   left_join: up in UserProfile, on: up.uid == upy.user_id, 
                   left_join: cs in Classes, on: up.class_id == cs.id,
                   left_join: p in Payments, on: p.id == upyd.payment_type_id,
                   select: {upy, upyd, up, cs, p},
                   where: upy.status == "closed"
                  )

      query = if data["class_id"] && data["class_id"] != "0" do
        from([upy, upyd, up, cs, p] in query, where: up.class_id == ^String.to_integer(data["class_id"]))
        else query
      end

      payments = Repo.all(query)    
      params = %{current_page: data["page"], total: 30, per_page: 10}
      {payments,  params}
    end

    def get_payment_totals(_conn, data \\ %{}) do

      # query = from(upyd in UserPaymentsDetails, 
      #              left_join: upy in UserPayments, on: upy.id == upyd.user_payments_id,
      #              left_join: up in UserProfile, on: up.uid == upy.user_id, 
      #              left_join: cs in Classes, on: up.class_id == cs.id,
      #              left_join: p in Payments, on: p.id == upyd.payment_type_id,
      #              where: upy.status == "closed",
      #              group_by: [upyd.payment_type_id, p.payment_name, up.class_id],
      #              order_by: p.payment_name,
      #              select: {sum(upyd.amount_paid), p.payment_name, up.class_id}
      #             )

      query = from(upyd in UserPaymentsDetails, 
                   left_join: upy in UserPayments, on: upy.id == upyd.user_payments_id,
                   left_join: up in UserProfile, on: up.uid == upy.user_id, 
                   left_join: cs in Classes, on: up.class_id == cs.id,
                   left_join: p in Payments, on: p.id == upyd.payment_type_id,
                   where: upy.status == "closed"
                  )


      query = if data["class_id"] && data["class_id"] != "0" do
         from([upyd, upy, up, cs, p] in query, 
           where: up.class_id == ^String.to_integer(data["class_id"]),
           group_by: [upyd.payment_type_id, p.payment_name, up.class_id],
           select: {sum(upyd.amount_paid), p.payment_name, up.class_id}
         )
      else 
        from([upyd, upy, up, cs, p] in query, 
           group_by: [upyd.payment_type_id, p.payment_name],
           select: {sum(upyd.amount_paid), p.payment_name, true}
         )
      end
      Repo.all(query)
    end
 
end