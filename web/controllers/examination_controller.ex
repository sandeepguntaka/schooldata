defmodule Schooldata.ExaminationController do
  @moduledoc false

  use Schooldata.Web, :controller

  alias Schooldata.Examination
  alias Schooldata.Section

  def index(conn, _) do

    exams1 = Repo.all(Examination)
    exams2 = Repo.preload exams1, :class
    exams = Repo.preload exams2, :section

    render conn, "index.html", exams: exams
  end

  def new(conn, _) do
    classes = Helper.class_list
    sections = Repo.all(from(s in Section, select: {s.id, s.name} )) |> Enum.map(fn({x, y}) -> {y, x} end )
    exam = Examination.changeset(%Examination{}, %{})
    #    exam = User.changeset(%User{}, %{})


    render conn, "new.html", exam: exam, classes: classes, sections: sections
  end

  def create(conn, %{"examination" => exam}) do
    %{"exam_date" => exam_date} = exam
    {_, x} = NaiveDateTime.new(
      String.to_integer(exam_date["year"]),
      String.to_integer(exam_date["month"]),
      String.to_integer(exam_date["day"]),
      0,
      0,
      0
    )
    {_, exam1} = Map.get_and_update(exam, "exam_date", fn y -> {y, x} end)

    exam2 = Examination.changeset(%Examination{}, exam1)
    case Repo.insert(exam2) do
      {:ok, _} ->
        conn
        |> put_flash(:success, "Unable to create account")
        |> redirect(to: examination_path(conn, :index))
      {:error, exam3} ->
        conn
        |> put_flash(:info, "Unable to create account")
        |> render("new.html", exam: exam3, classes: Helper.class_list)
    end
  end

end
