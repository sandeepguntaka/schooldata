defmodule Schooldata.SectionController do
  @moduledoc false

  use Schooldata.Web, :controller
  alias Schooldata.Section


  def index(conn, _) do


    sections = Repo.all(Section)

    conn
    |> render("index.html", sections: sections)
  end

  def new(conn, _) do
    section = Section.changeset(%Section{}, %{})
    render conn, "form.html", section: section
  end

  def create(conn, %{"section" => section}) do
    section = Section.changeset(%Section{}, section)

    case Repo.insert(section) do
      {:ok, _} ->
        conn
        |> put_flash(:success, "Section saved")
        |> redirect(to: "/sections")
      {:error, sec} ->
        conn
        |> put_flash(:error, "Section not saved")
        |> render("form.html", section: sec)
    end
  end

end
