defmodule ObesebirdApi.Slot do
  use ObesebirdApi.Web, :model

  schema "slots" do
    field :day_of_week, :integer
    field :hour, :integer
    field :min, :integer
    belongs_to :category, ObesebirdApi.Category

    timestamps
  end

  @required_fields ~w(day_of_week hour min)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
