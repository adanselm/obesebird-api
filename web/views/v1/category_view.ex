defmodule ObesebirdApi.V1.CategoryView do
  use ObesebirdApi.Web, :view

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, ObesebirdApi.V1.CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, ObesebirdApi.V1.CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id, name: category.name}
  end
end
