defmodule Schooldata.Examination do
    use Schooldata.Web, :model
    
    schema "examinations" do
      field :total_marks, :integer
      field :exam_date, :naive_datetime
      field :passing_marks, :integer
      belongs_to :class, Schooldata.Classes
      belongs_to :section, Schooldata.Section
    end


    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:total_marks,  :exam_date, :passing_marks,:class_id, :section_id])
      |> validate_required([:total_marks , :exam_date, :passing_marks,:class_id, :section_id])
    end
end