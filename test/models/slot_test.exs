defmodule ObesebirdApi.SlotTest do
  use ObesebirdApi.ModelCase

  alias ObesebirdApi.Slot

  @valid_attrs %{category: nil, day_of_week: 42, hour: 42, min: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Slot.changeset(%Slot{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Slot.changeset(%Slot{}, @invalid_attrs)
    refute changeset.valid?
  end
end
