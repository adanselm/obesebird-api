defmodule ObesebirdApi.V1.CategoryControllerTest do
  use ObesebirdApi.ConnCase

  alias ObesebirdApi.Category
  @valid_attrs %{title: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_category_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    category = Repo.insert %Category{}
    conn = get conn, v1_category_path(conn, :show, category)
    assert json_response(conn, 200)["data"] == %{
      "id" => category.id
    }
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_category_path(conn, :create), category: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Category, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_category_path(conn, :create), category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    category = Repo.insert %Category{}
    conn = put conn, v1_category_path(conn, :update, category), category: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Category, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    category = Repo.insert %Category{}
    conn = put conn, v1_category_path(conn, :update, category), category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    category = Repo.insert %Category{}
    conn = delete conn, v1_category_path(conn, :delete, category)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(Category, category.id)
  end
end
