defmodule ObesebirdApi.Post do
  use ObesebirdApi.Web, :model

  schema "posts" do
    field :message, :string
    belongs_to :category, ObesebirdApi.Category

    timestamps
  end

  @required_fields ~w(message)
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
