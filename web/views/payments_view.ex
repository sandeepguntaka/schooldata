defmodule Schooldata.PaymentsView do
    use Schooldata.Web, :view

    def side_menu(conn, assigns, current_item) do
       user = assigns[:current_user]
       roles = assigns[:roles]
       side_menu = [view_all_payments: %{title: "Payments Dashboard", path: payments_path(conn, :index)}]
       side_menu = Keyword.put_new(side_menu, :payment_types, %{title: "Fee Structure", path: payment_details_path(conn, :index)}) 
       side_menu = Keyword.put_new(side_menu, :payment_list, %{title: "Payments List", path: payment_details_path(conn, :list)}) 
       side_menu = Keyword.put_new(side_menu, :add_payments, %{title: "Add New Payment", path: payments_path(conn, :new)}) 

       {_, side_menu} = Keyword.get_and_update(side_menu, current_item, fn cv -> {cv, Map.put(cv, :active, "active")} end)
        
       Enum.reverse side_menu

    end
end