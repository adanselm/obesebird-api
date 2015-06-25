defmodule ObesebirdApi.V1.SlotController do
  use ObesebirdApi.Web, :controller

  alias ObesebirdApi.Slot
  alias ObesebirdApi.Scheduler

  plug :scrub_params, "slot" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    slots = Repo.all(Slot)
    render(conn, "index.json", slots: slots)
  end

  def create(conn, %{"slot" => slot_params}) do
    changeset = Slot.changeset(%Slot{}, slot_params)

    if changeset.valid? do
      slot = Repo.insert(changeset)
      restart_scheduler()
      render(conn, "show.json", slot: slot)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ObesebirdApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    slot = Repo.get(Slot, id)
    render conn, "show.json", slot: slot
  end

  def update(conn, %{"id" => id, "slot" => slot_params}) do
    slot = Repo.get(Slot, id)
    changeset = Slot.changeset(slot, slot_params)

    if changeset.valid? do
      slot = Repo.update(changeset)
      restart_scheduler()
      render(conn, "show.json", slot: slot)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(ObesebirdApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    slot = Repo.get(Slot, id)

    slot = Repo.delete(slot)
    restart_scheduler()
    render(conn, "show.json", slot: slot)
  end

  defp restart_scheduler() do
    Scheduler.stop(ObesebirdApi.Scheduler)
  end
end
