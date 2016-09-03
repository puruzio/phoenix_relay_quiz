defmodule App.Category do
  use App.Web, :model

  schema "categories" do
    belongs_to :quizs, App.Quiz
    field :category, :string
    field :categoryType, :string

    timestamps
  end

  @required_fields ~w(quiz_id category categoryType)
#   @optional_fields ~w(mediaUrl typeCode)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
