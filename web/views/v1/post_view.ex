defmodule ObesebirdApi.V1.PostView do
  use ObesebirdApi.Web, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, ObesebirdApi.V1.PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, ObesebirdApi.V1.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id, text: post.text, category_id: post.category_id,
    creation_date: post.inserted_at,
    last_submission_date: post.last_submission_date,
    is_queued: post.is_queued }
  end
end
