defmodule ObesebirdApi.V1.CategoryController do
  use ObesebirdApi.Web, :controller

  alias ObesebirdApi.Category

  plug :scrub_params, "category" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.json", categories: categories)
  end

  def create(conn, %{"category" => category_params}) do
    changeset = Category.changeset(%Category{}, category_params)

    if changeset.valid? do
      category = Repo.insert(changeset)
      render(conn, "show.json", category: category)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ObesebirdApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    category = Repo.get(Category, id)
    render conn, "show.json", category: category
  end

  def update(conn, %{"id" => id, "category" => category_params}) do
    category = Repo.get(Category, id)
    changeset = Category.changeset(category, category_params)

    if changeset.valid? do
      category = Repo.update(changeset)
      render(conn, "show.json", category: category)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ObesebirdApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    category = Repo.get(Category, id)

    category = Repo.delete(category)
    render(conn, "show.json", category: category)
  end
end
