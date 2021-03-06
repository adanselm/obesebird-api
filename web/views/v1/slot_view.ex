defmodule ObesebirdApi.V1.SlotView do
  use ObesebirdApi.Web, :view

  def render("index.json", %{slots: slots}) do
    %{data: render_many(slots, ObesebirdApi.V1.SlotView, "slot.json")}
  end

  def render("show.json", %{slot: slot}) do
    %{data: render_one(slot, ObesebirdApi.V1.SlotView, "slot.json")}
  end

  def render("slot.json", %{slot: slot}) do
    %{id: slot.id, day_of_week: slot.day_of_week, hour: slot.hour,
      min: slot.min, category_id: slot.category_id}
  end
end
