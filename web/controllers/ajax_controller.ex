defmodule Schooldata.AjaxController do
    use Schooldata.Web, :controller
    

    def student_id_json(conn, %{"class_id" => class_id}) do 
      students = Helper.get_student_ids(class_id)
      json conn, Enum.into(students, %{})
    end

    # def student_name_json(conn, %{"code" => student_id}) do 
    #   destinations = Helper.get_student_name(student_id)
    #   [_ | destinations] = destinations
    #   json conn, Enum.into(destinations, %{})
    # end

end
