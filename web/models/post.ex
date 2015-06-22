defmodule ObesebirdApi.Post do
  use ObesebirdApi.Web, :model

  schema "posts" do
    field :text, :string
    field :last_submission_date, Ecto.DateTime
    field :is_queued, :boolean, default: false
    belongs_to :category, ObesebirdApi.Category

    timestamps
  end

  @required_fields ~w(text)
  @optional_fields ~w(last_submission_date is_queued)

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
