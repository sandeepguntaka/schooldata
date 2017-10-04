defmodule Helper do
    alias Schooldata.Repo
    import Plug.Conn
    import Ecto.Query 

    alias Schooldata.Classes
    alias Schooldata.UserProfile
    alias Schooldata.Sections
    alias Schooldata.UserRoles
    alias Schooldata.Payments 

    def load_user_details(id) do
      if id do
       user = Repo.get_by(UserProfile, [uid: id])
      else 
       []
      end
    end

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

    def get_student_ids(class_code) do
      query = from(up in UserProfile,
                   select: %{uid: up.uid, name: up.full_name}, 
                   where: up.class_id == ^String.to_integer(class_code)
                  )
        classes = Repo.all(query)
        class_list = Enum.reduce(classes, [], fn(class, acc) ->
          [{class[:name], class[:uid]} | acc] 
        end)
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