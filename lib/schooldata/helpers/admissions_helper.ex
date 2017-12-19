defmodule AdmissionsHelper do
    alias Schooldata.Repo
    import Ecto.Query

    alias Schooldata.Classes
    alias Schooldata.StudentProfile

  def get_admissions_list(data \\ %{}) do
      query = from(sp in StudentProfile, 
                   left_join: cs in Classes, on: cs.id == sp.class_id,
                   select: {sp, cs},
                  )

      query = if data["class_id"] && data["class_id"] != "0" do
        from([sp, cs] in query, where: sp.class_id == ^String.to_integer(data["class_id"]))
        else query
      end

      admissions = Repo.all(query)    
      params = %{current_page: data["page"], total: 30, per_page: 10}
      {admissions,  params}
    end

end