defmodule Schooldata.UserProfileTest do
  use Schooldata.ModelCase

  alias Schooldata.UserProfile

  @valid_attrs %{"": ~N[2010-04-17 14:00:00.000000], address: "some address", date_of_birth: "some date_of_birth", father_name: "some father_name", fullname: "some fullname", joining_date: "some joining_date", mobile: 42, mother_name: "some mother_name", roll_number: "some roll_number"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserProfile.changeset(%UserProfile{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserProfile.changeset(%UserProfile{}, @invalid_attrs)
    refute changeset.valid?
  end
end
