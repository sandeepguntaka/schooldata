defmodule Schooldata.SchooldataTest do
  use Schooldata.ModelCase

  alias Schooldata.Schooldata

  @valid_attrs %{crypted_password: "some crypted_password", is_active: "some is_active", name: "some name", username: "some username"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Schooldata.changeset(%Schooldata{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Schooldata.changeset(%Schooldata{}, @invalid_attrs)
    refute changeset.valid?
  end
end
