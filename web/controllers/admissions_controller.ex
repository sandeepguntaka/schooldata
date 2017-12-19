defmodule Schooldata.AdmissionsController do
    use Schooldata.Web, :controller

    alias Schooldata.StudentProfile

    
    def index(conn, params) do
      {admissions, assigns} = AdmissionsHelper.get_admissions_list(params)
     
      assigns = Map.put(assigns, :url, admissions_path(conn, :index))
      assigns = Map.put(assigns, :current_page, 1)
      assigns = Map.put(assigns, :per_page, 25)
      assigns = Map.put(assigns, :total, 3)
      render conn, "admissions-list.html" , assigns: assigns, 
                                         admissions: admissions, 
                                         filters: params
                                         
    end

    def new(conn, _params) do
      changeset = StudentProfile.changeset(%StudentProfile{}, %{})
      render conn, "admissions-new.html", changeset: changeset
    end

    def create(conn, %{"student_profile" => student_profile}) do
      date_of_birth = student_profile["date_of_birth"]
      { _ , dob } = NaiveDateTime.new(String.to_integer(date_of_birth["year"]),
          String.to_integer(date_of_birth["month"]),
          String.to_integer(date_of_birth["day"]), 0 ,0, 0)

      tc = if student_profile["tc_submitted"] == "true", do: 1, else: 0
      cc = if student_profile["conduct_certificate_submitted"] == "true", do: 1, else: 0
       
      student_profile = Map.put(student_profile, "date_of_birth", dob)
      student_profile = Map.put(student_profile, "admission_status", "Open")
      student_profile = Map.put(student_profile, "tc_submitted", tc)
      student_profile = Map.put(student_profile, "conduct_certificate_submitted", cc)


      changeset = %StudentProfile{} |> StudentProfile.changeset(student_profile)
    
      case Repo.insert(changeset) do
        {:ok, _} ->
          conn
            |> put_flash(:info, "Admission created Successfully!")
            |> redirect(to: "/")
        {:error, changeset} ->
          conn
          |> put_flash(:info, "Unable to create account")
          |> render("admissions-new.html", changeset: changeset)
      end
    end

    def import(conn, params) do
      case conn.method do
        "GET" -> 
          changeset = StudentProfile.changeset(%StudentProfile{}, %{})
          render conn, "admissions-import.html", changeset: changeset
        "POST" ->
          changeset = StudentProfile.changeset(%StudentProfile{}, %{})
          if Helper.is_empty(params["student_profile"]["csv"]) do
            conn
              |> put_flash(:error, "File not selected")
              |> render("admissions-import.html", changeset: changeset)
          end 
          errors = []
          if upload = params["student_profile"]["csv"] do
            extension = Path.extname(upload.filename)
            classes = Helper.get_classes
            
            dest = Path.absname("uploads/admissions/#{Date.utc_today |> to_string}#{extension}")
            case File.cp(upload.path, dest) do
              :ok ->
               upload.path
                  |> File.stream!()
                  |> Stream.drop(1)
                  |> CSV.decode(headers: ["sno", "first_name", "last_name", "gender", "class_id", "medium",
                         "date_of_birth", "place_of_birth", "blood_group", "nationality", "religion", "caste", "student_living_with"])
                  |> Enum.flat_map(fn(user) ->
                      { _, dob} = Timex.parse(user["date_of_birth"] , "{D}/{M}/{YYYY}")
                      user = Map.merge(user, %{"first_name" => String.capitalize(user["first_name"]), 
                                  "last_name" => String.capitalize(user["last_name"]),
                                  "gender" => String.capitalize(user["gender"]),
                                  "admission_status" => "Open" })

                    if !Helper.is_empty(user["class_id"]) do
                      if String.length(user["class_id"]) > 2 do
                        class = Enum.find(classes, fn({key, _}) ->
                                  String.capitalize(key) == String.capitalize(user["class_id"]) 
                            end)
                      else
                        class = Enum.find(classes, fn({_, value}) ->
                                  value == String.to_integer(user["class_id"]) 
                            end)
                      end
                      if class != nil , do: { _ , class_id } = class
                    end

                      if class_id != nil , do: user = Map.put(user, "class_id", class_id)                     
                      user = Map.put(user, "date_of_birth", dob)
                      
                      changeset = %StudentProfile{} |> StudentProfile.changeset(user)
                      
                      if changeset.errors == [] do
                        Repo.insert(changeset) 
                        errors
                      else
                        [ user["sno"] | errors ]
                      end

                     end)

                  conn
                    |> put_flash(:info, "Admission Uploaded Successfully!")
                    |> redirect(to: "/admissions")

              {:error, _ } ->
                conn
                |> put_flash(:error, "Unable to Upload File")
                |> render("admissions-import.html", changeset: changeset)
            end
          end


      end
      
    end

end