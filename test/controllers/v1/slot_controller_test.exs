defmodule ObesebirdApi.V1.SlotControllerTest do
  use ObesebirdApi.ConnCase

  alias ObesebirdApi.Slot
  @valid_attrs %{day_of_week: 42, hour: 42, min: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_slot_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = get conn, v1_slot_path(conn, :show, slot)
    assert json_response(conn, 200)["data"] == %{
      "id" => slot.id,
      "category_id" => slot.category_id,
      "day_of_week" => slot.day_of_week,
      "hour" => slot.hour,
      "min" => slot.min
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_slot_path(conn, :create), slot: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Slot, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_slot_path(conn, :create), slot: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = put conn, v1_slot_path(conn, :update, slot), slot: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Slot, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = put conn, v1_slot_path(conn, :update, slot), slot: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    slot = Repo.insert %Slot{}
    conn = delete conn, v1_slot_path(conn, :delete, slot)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Slot, slot.id)
  end
end
