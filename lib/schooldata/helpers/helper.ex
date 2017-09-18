defmodule Helper do
    alias Schooldata.Repo
    import Plug.Conn
    import Ecto.Query 

    alias Schooldata.Classes
    alias Schooldata.Sections
    alias Schooldata.UserRoles
    alias Schooldata.Payments 


    def logged_in_roles(current_user) do
      if current_user != nil do
        #user = String.to_integer(current_user.id);
        query = from ur in UserRoles,
          select: ur.rid, where: [uid: ^current_user.id]
        roles = Repo.all(query)
      end
    end

    def role_menus(roles) do
        if Enum.count(roles) > 0 do
          # IO.puts "++++++"
           #IO.inspect(roles)
           #IO.puts "++++++"
        end
        
    end

    def get_classes do
        classes = Repo.all(Classes)
    end

    def get_payment_types do
        payments = Repo.all(Payments)
    end

    def get_sections do
        Repo.all(Sections)
    end

    def get_section_name do
        Repo.all(Sections)
    end

    def get_class_name do
        Repo.all(Sections)
    end
end