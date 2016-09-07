defmodule App.Quiz do
  use App.Web, :model

  schema "quizs" do
    belongs_to :user, App.User, foreign_key: :user_id, type: :binary_id
    field :question, :string
    field :author, :string
    field :choices, :string
    field :mediaUrl, :string
    field :typeCode, :string

    has_many :categories, App.Category
    timestamps
  end

  @required_fields ~w(user_id question author choices)
  @optional_fields ~w(mediaUrl typeCode)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def categories do
      []
  end
end
