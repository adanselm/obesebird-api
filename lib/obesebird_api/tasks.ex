defmodule ObesebirdApi.Tasks do
  import Ecto.Query

  alias ObesebirdApi.Slot
  alias ObesebirdApi.Post
  alias ObesebirdApi.Repo
  require Logger

  def get(day_of_week, {hour, min, _sec}) do
    query = from s in Slot,
      where: s.day_of_week == ^day_of_week and (s.hour > ^hour or (s.hour == ^hour and s.min >= ^min)),
      order_by: [asc: s.hour, asc: s.min],
      select: s
    Repo.all(query)
  end

  def execute(id) do
    time = Ecto.DateTime.from_erl(:calendar.universal_time())
    publish(get_next_post(id), time)
  end

  defp get_next_post(category_id) do
    query = from p in Post,
      where: p.category_id == ^category_id,
      order_by: [asc: p.last_submission_date],
      select: p
    Repo.one(query)
  end

  defp publish(nil, _time) do
    Logger.warn "Nothing to publish"
  end
  defp publish(%Post{text: text, category_id: id} = post, time) do
    timestr = Ecto.DateTime.to_string time
    Logger.info "Publishing category #{id} at #{timestr}"
    ExTwitter.update(text)
    update_date post, time
  end

  defp update_date(post, time) do
    changeset = Post.changeset(post, %{last_submission_date: time})
    if changeset.valid? do
      Repo.update(changeset)
    else
      Logger.error "Could not update submission date."
    end
  end

end
