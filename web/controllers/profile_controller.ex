defmodule Schooldata.ProfileController do
    use Schooldata.Web, :controller
    
    alias Schooldata.UserProfile
    alias Schooldata.User

    def edit(conn, %{"id" => user_id}) do
        class_list = Enum.reduce(Helper.get_classes(), [], fn(f, acc) -> 
            [{ f.name, f.id}| acc]
        end) |> Enum.reverse
    
        section_list = Enum.reduce(Helper.get_sections(), [], fn(f, acc) -> 
            [{ f.name, f.id}| acc]
        end) |> Enum.reverse
    
        
        user = Repo.get_by(UserProfile,[uid: user_id ])
        changeset = UserProfile.changeset(user)

        class_sections = %{classes: class_list, sections: section_list}
        render conn, "edit.html", changeset: changeset, user: user, class_sections: class_sections
    end
    
    def update(conn, %{"id" => id, "user_profile" => user_profile}) do
        old_profile = Repo.get(UserProfile, id)
        %{"joining_date" => joining_date, 
          "date_of_birth" => date_of_birth,
          "mobile" => mobile,
          "roll_number" => roll_number,
          "class_id" => class_id,
          "section_id" => section_id} = user_profile
        { _ , joindate } = NaiveDateTime.new(String.to_integer(joining_date["year"]),
          String.to_integer(joining_date["month"]),
          String.to_integer(joining_date["day"]), 0 ,0, 0)

        { _ , dob } = NaiveDateTime.new(String.to_integer(date_of_birth["year"]),
          String.to_integer(date_of_birth["month"]),
          String.to_integer(date_of_birth["day"]), 0 ,0, 0)

        user_profile = Map.put(user_profile, "joining_date", joindate)
        user_profile = Map.put(user_profile, "date_of_birth", dob)
        user_profile = Map.put(user_profile, "mobile", String.to_integer(mobile))
        
        user_profile = Map.put(user_profile, "class_id", String.to_integer(class_id))
        user_profile = Map.put(user_profile, "section_id", String.to_integer(section_id))



        IO.puts "++++++++++++"
        IO.inspect(user_profile)
        IO.puts "++++++++++++++"

        changeset = UserProfile.changeset(old_profile, user_profile)
       
        user = Repo.get!(User, conn.assigns.current_user.id)

        class_list = Enum.reduce(Helper.get_classes(), [], fn(f, acc) -> 
            [{ f.name, f.id}| acc]
        end) |> Enum.reverse
    
        section_list = Enum.reduce(Helper.get_sections(), [], fn(f, acc) -> 
            [{ f.name, f.id}| acc]
        end) |> Enum.reverse

        class_sections = %{classes: class_list, sections: section_list}
        

        case Repo.update(changeset) do
            {:ok, _profile} ->
                    conn
                    |> put_flash(:info, "Profile Updated")
                    |> redirect(to: registration_path(conn, :profile, user))
                {:error, changeset} ->
                    render conn, "edit.html", changeset: changeset, user: user, class_sections: class_sections
            end

    end
    
end