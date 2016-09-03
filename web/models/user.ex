defmodule App.User do
  use App.Web, :model
  use Ecto.Schema

# :binary_id is managed by drivers/adapters, it will be UUID for mysql, postgres
  #  but can be ObjectID if later you decide to use mongo
  # http://websymphony.net/blog/2015/06/28/how-to-use-uuid-as-primary-key-in-ecto-phoenix/
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    has_many :quizs, App.Quiz

    timestamps
  end

  @required_fields ~w(username email)
  @optional_fields ~w()

  def quizs do
    []
  end
  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:username, min: 1, max: 20)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
